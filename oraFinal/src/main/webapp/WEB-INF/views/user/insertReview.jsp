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
</style>
<link rel="stylesheet" type="text/css" href="/ckeditor5/editor-styles.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/ckeditor5/build/ckeditor.js"></script>
<script type="text/javascript">
let current_urls = [];		// 현재 editor에 있는 img src들의 배열을 담은 변수. url저장형식 => /review/46076431.jpg
$(document).ready(function(){
	
	if(${rtvo == null}) {	// 기존 작성중인 게시글이 없을 경우 신규 임시저장 레코드 생성
		createReviewTempRecord();
	}else {
		let answer = confirm("작성중인 게시글이 있습니다. 불러올까요?");
		if(answer) {		// 작성중인 게시글 불러오기. controller에서 model에 rtvo를 실은 것을 불러온다.
			$("#r_title").val('${rtvo.r_title}');
			$("#c_no").val(${rtvo.c_no});
			$("#editor").text('${rtvo.r_content}');
		}
	}
	
	// let pluginList = ClassicEditor.builtinPlugins.map( plugin => plugin.pluginName );
	// console.log(pluginList);	// 사용가능한 플러그인 리스트

	ClassicEditor
	.create( document.querySelector( '#editor' ), {
		removePlugins: [ 'ImageCaption' ],		// 불필요한 플러그인 삭제
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
                uploadFolder: 'review'
            }
        },
		autosave: {
			waitingTime: 1000,	// ms단위. 마지막 변화감지 후 설정한 시간만큼 대기 한 후 이벤트 처리
			save(editor) {
				return saveData(editor.getData());
			}
		},
		mediaEmbed : {
			previewsInData: true	// 이거 안하면 동영상 표시가 안됨. 
		}
		
	} )
	.then( editor => {
		window.editor = editor;		// 기본값
		displayStatus( editor );	// 기본값
		//console.log( editor );	// 에디터 객체 전체 정보
		
		// ***** 실시간 이미지 삭제 코드 시작 *****
		editor.model.document.on( 'change:data', (eventInfo) => {
			//console.log( eventInfo );
			//console.log("현재URL:"+current_urls);
			let after_urls = Array.from( new DOMParser().parseFromString( editor.getData(), 'text/html' )
		    .querySelectorAll( 'img' ) )
		    .map( img => img.getAttribute( 'src' ) );	// 현재 editor에 있는 img src들의 배열 저장
		    //console.log("이후URL:"+after_urls);
		    
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
						imageDelete(deleted_url);
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
	
	$("#inputInsert").click(function(){		// 게시글 등록버튼 누르면 image src배열정보 전달. 이것을 토대로 review_file table에 record등록.
		let $image_urls = $("<input>").attr({
			type: "hidden",
			name: "image_urls",
			value: current_urls
		});
		$(this).parent("form").append($image_urls);
	});

});

// 사용자가 insert한 이미지 삭제 시 비동기 삭제처리를 위한 함수
function imageDelete(url){
	$.ajax({
		url: "/reviewImageDelete",
		beforeSend : function(xhr){
            xhr.setRequestHeader("uploadFolder", "review");
        },
		data: {url: url},
		success: function(data){

		}
	});
}
// 작성중인 게시글이 없을 경우 review_temp테이블에 empty record생성 
function createReviewTempRecord() {
	$.ajax({
		url: "/createReviewTempRecord",
		success: function(response){
			
		}
	});
}
// autosave 함수
function saveData( data ) {
	let r_title = $("#r_title").val();
	let c_no = $("#c_no").val();
    $.ajax({
		url: "/reviewAutoSave",
		method: "post",
		data: {
			r_title: r_title,
			c_no: c_no,
			r_content: data
		},
		success: function(res){

		}
    });
}

// Update the "Status: Saving..." info.
function displayStatus( editor ) {
    const pendingActions = editor.plugins.get( 'PendingActions' );
    const statusIndicator = document.querySelector( '#snippet-autosave-status' );

    pendingActions.on( 'change:hasAny', ( evt, propertyName, newValue ) => {
        if ( newValue ) {
            statusIndicator.classList.add( 'busy' );
        } else {
            statusIndicator.classList.remove( 'busy' );
        }
    } );
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
	
	<form action="/user/insertReview" method="post">
	제목 <input type="text" name="r_title" id="r_title" size="50" required="required"><br><br>
		
		<div>
			코스 
			<select name="c_no" id="c_no">
				<c:forEach var="vo" items="${list }">
					<option value="${vo.c_no }">${vo.c_name }</option>
				</c:forEach>
			</select>
		</div>
		<br><br>
		<hr><br>
		<!-- 글내용 -->
		<textarea name="r_content" id="editor"></textarea>
		<!-- autosave 상태표시창 -->
		<div id="snippet-autosave-status">
			<div id="snippet-autosave-status_label">Status:</div>
			<div id="snippet-autosave-status_spinner">
				<span id="snippet-autosave-status_spinner-label"></span>
				<span id="snippet-autosave-status_spinner-loader"></span>
			</div>
		</div>
		<input type="submit" value="등록" id="inputInsert">
		<input type="reset" value="취소">
	</form>
	
</section>
<jsp:include page="../footer.jsp"/>
</body>
</html>