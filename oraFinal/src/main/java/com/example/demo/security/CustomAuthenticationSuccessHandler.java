package com.example.demo.security;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.example.demo.ResponseDataCode;
import com.example.demo.ResponseDataStatus;
import com.example.demo.dao.MemberDao;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.ResponseDataVo;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.Setter;


/**
 * 로그인 성공시 핸들러
 * 
 */
@Component
public class CustomAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
	
	@Autowired
	@Setter
	private MemberDao mdao;
	/**
	 * 로그인이 성공하고나서 로직
	 */
	
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws ServletException, IOException {
		
    	HttpSession session = request.getSession(false);  //실패했을때 에러세션을 지워준다
        if(session != null) {
        	session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
        	System.out.println("실패에러세션 삭제");
        }
        
        Authentication aut = SecurityContextHolder.getContext().getAuthentication();
    	User user = (User)aut.getPrincipal();
        MemberVo m = mdao.selectMember(user.getUsername());
        System.out.println(m);
        request.getSession().setAttribute("m", m);
        String[] loginMsgArr = {"님 오늘도 달려볼까요?", "님 '코스검색'을 통해 빠르게 원하는 코스를 찾아보세요!", "님 '번개게시판'을 통해 여러사람과 즐겨보세요!"
        		,"님 '코스만들기'를 통해 나만의 코스를 만들어보세요!", "님 '후기게시판'을 통해 다른 라이더님과 코스후기를 공유해보세요!"};
        Random random = new Random();
        int r = random.nextInt(loginMsgArr.length);
        String loginMsg = m.getNickName()+loginMsgArr[r];
        
    	ObjectMapper mapper = new ObjectMapper();	//JSON 변경용
    	
    	ResponseDataVo responseDataVo = new ResponseDataVo();
    	responseDataVo.setCode(ResponseDataCode.SUCCESS);
    	responseDataVo.setStatus(ResponseDataStatus.SUCCESS);
    	
    	String prevPage = request.getSession().getAttribute("prevPage").toString();	//이전 페이지 가져오기
    	request.getSession().removeAttribute("prevPage");
    	
    	Map<String, String> items = new HashMap<String,String>();	
    	items.put("url", prevPage);	// 이전 페이지 저장
    	responseDataVo.setItem(items);
    	responseDataVo.setMessage(loginMsg);
    	
        
    	response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print(mapper.writeValueAsString(responseDataVo));
        response.getWriter().flush();
        System.out.println("마지막성공핸들러작동");
        
    }
}