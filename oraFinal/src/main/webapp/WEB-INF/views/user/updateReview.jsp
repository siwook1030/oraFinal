<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
section {
	margin: 0 auto;
	width: 1000px;
	text-align: left;
}
#submitWrap {
	display: flex;
	flex-direction: row;
	justify-content: flex-end;
}

</style>
<link rel="stylesheet" type="text/css" href="/ckeditor5/editor-styles.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/ckeditor5/build/ckeditor.js"></script>
<script type="text/javascript">

let current_urls = [];		// 현재 editor에 있는 img src들의 배열을 담은 변수
$(document).ready(function(){
	// let pluginList = ClassicEditor.builtinPlugins.map( plugin => plugin.pluginName );
	// console.log(pluginList);	// 사용가능한 플러그인 리스트
	
	$("#r_title").val('${rvo.r_title}');
	$("#editor").text('${rvo.r_content}');
	
	ClassicEditor
	.create( document.querySelector( '#editor' ), {
		removePlugins: [ 'ImageCaption', 'Autosave' ],		// 불필요한 플러그인 삭제
		toolbar: {			
			items: [		// 툴바에 표시할 아이콘 정의
				'heading',
				'|',
				'bold',
				'italic',
				'link',
				'bulletedList',
				'numberedList',
				'|',
				'alignment',
				'indent',
				'outdent',
				'|',
				'imageUpload',
				'blockQuote',
				'insertTable',
				'mediaEmbed',
				'undo',
				'redo',
				'|',
				'fontBackgroundColor',
				'fontColor',
				'fontSize',
				'fontFamily',
				'specialCharacters',
				'underline',
				'|'
			]
		},
		language: 'ko',
		image: {
			// Configure the available styles.
            styles: [
                'alignLeft', 'alignCenter', 'alignRight'
            ],

            // Configure the available image resize options.
            resizeOptions: [
                {
                    name: 'imageResize:original',
                    label: 'Original',
                    value: null
                },
                {
                    name: 'imageResize:50',
                    label: '50%',
                    value: '50'
                },
                {
                    name: 'imageResize:75',
                    label: '75%',
                    value: '75'
                }
            ],

            // You need to configure the image toolbar, too, so it shows the new style
            // buttons as well as the resize buttons.
            toolbar: [
                'imageStyle:alignLeft', 'imageStyle:alignCenter', 'imageStyle:alignRight',
                '|',
                'imageResize'
                //'|',
                //'imageTextAlternative'
            ]
		},
		table: {
			contentToolbar: [
				'tableColumn',
				'tableRow',
				'mergeTableCells',
				'tableCellProperties',
				'tableProperties'
			]
		},
		licenseKey: '',
		//plugins: [ SimpleUploadAdapter ],
        simpleUpload: {
            // The URL that the images are uploaded to.
            uploadUrl: '/reviewImageInsert',

            // Enable the XMLHttpRequest.withCredentials property.
            withCredentials: true,		// 기본값

            // Headers sent along with the XMLHttpRequest to the upload server.
            headers: {
                'X-CSRF-TOKEN': 'CSRF-Token',				// 기본값
                Authorization: 'Bearer <JSON Web Token>',	// 기본값
                uploadFolder: 'review_temp'
            }
        },
		mediaEmbed : {
			previewsInData: true	// 이거 안하면 동영상 표시가 안됨. 
		}
		
	} )
	.then( editor => {
		window.editor = editor;		// 기본값
		//console.log( editor );	// 에디터 객체 전체 정보
		current_urls = checkImageUrls(editor);
		//console.log("현재imageURLs:"+current_urls);
		// ***** 실시간 이미지 삭제 코드 시작 *****
		editor.model.document.on( 'change:data', (eventInfo) => {
			//console.log( eventInfo );
			let after_urls = checkImageUrls(editor);
		    let deleted_url;
		    if(current_urls.length > after_urls.length) {
			    console.log("이미지 삭제됨!");
				for(let i = 0; i < current_urls.length; i++) {
					let isChanged = true;
					for(let j = 0; j < after_urls.length; j++) {
						if(current_urls[i] === after_urls[j]) {
							isChanged = false;
							break;
						}
					}
					if(isChanged) {
						deleted_url = current_urls[i];
						//console.log("삭제된URL:"+deleted_url);
						imageDelete(deleted_url, true);
						break;
					}
				}
			}
		    current_urls = after_urls;
		});
		// ***** 실시간 이미지 삭제 코드 끝 *****
	} )
	.catch( error => {
		console.error( 'Oops, something went wrong!' );
		console.error( 'Please, report the following error on https://github.com/ckeditor/ckeditor5/issues with the build id and the error stack trace:' );
		console.warn( 'Build id: b5mnviaze78m-31mkvnarb2x6' );
		console.error( error );
		
	} );
	
	$("#inputInsert").click(function(){		// 게시글 수정버튼 누르면 image src배열정보 전달. 이것을 토대로 review_file table에 record등록.
		$("#image_urls").attr("value", current_urls);
	});

	$("#btnCancle").click(function(){
		// input type submit이 아닌 그냥 button이어도 누르면 submit해버린다. 그래서 기본이벤트 삭제처리함.
		event.preventDefault();
		imageDelete(current_urls, false);
		location.href = "/detailReview?r_no=${rvo.r_no }";
	});
	
});

// 사용자가 insert한 이미지 삭제 시 비동기 삭제처리를 위한 함수
function imageDelete(urls, async){
	$.ajax({
		url: "/reviewImageDelete",
		beforeSend : function(xhr){
            xhr.setRequestHeader("uploadFolder", "review_temp");	// 삭제할 파일위치 정보전달
        },
        method: "post",
    	// string배열 전송용도. default인 false로 보내면 urls[] 로 보내서 컨트롤러의 String[] urls에서 받지못해서 null이 뜬다.
        traditional: true,
        // 에디터에서 사용자가 직접삭제할때는 비동기방식, 취소버튼으로 나갈때는 동기방식
        // 취소버튼으로 나갈때 비동기방식으로 하면 파일이 삭제되기전에 페이지를 나가서 처리가 되지 않는다.		
        async: async,
		data: {urls: urls},
		success: function(res){
			
		}
	});
}

function checkImageUrls(editor) {
	return Array.from( new DOMParser().parseFromString( editor.getData(), 'text/html' )
	.querySelectorAll( 'img' ) )
	.map( img => img.getAttribute( 'src' ) );	// 현재 editor에 있는 img src들의 배열 저장
}

</script>
</head>
<body>

<jsp:include page="../header.jsp"/>

<section>
	<br>
	<p style="font-size: 20px">후기 게시판&nbsp;&gt;&nbsp;<font color="#c85725">게시글 등록</font></p>
	<p style="font-size: 15px">라이딩 경험을 공유해요.</p>

  	<!-- 글등록 -->
	<br><br>
	
	<form action="/user/updateReview" method="post">
	제목 <input type="text" name="r_title" id="r_title" size="50" required="required""><br><br>
		
		<div>
			코스 
			<select name="c_no" id="c_no">
				<c:forEach var="vo" items="${list }">
					<c:choose>
						<c:when test="${vo.c_no == rvo.c_no}">
							<option value="${vo.c_no }" selected="selected">${vo.c_name }</option>
						</c:when>
						<c:otherwise>
							<option value="${vo.c_no }">${vo.c_name }</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
		</div>
		<br><br>
		<hr><br>
		<!-- 글내용 -->
		<textarea name="r_content" id="editor"></textarea>
		<!-- 현재 editor에 있는 img src들의 배열 전달 -->
		<input type="hidden" id="image_urls" name="image_urls">
		<input type="hidden" name="r_no" value="${rvo.r_no }">
		<div id="submitWrap">
			<input type="submit" value="수정" id="inputInsert">
			<button id="btnCancle">취소</button>
		</div>
	</form>
	
</section>
<jsp:include page="../footer.jsp"/>
</body>
</html>