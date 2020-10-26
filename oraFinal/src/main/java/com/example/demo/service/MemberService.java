package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.vo.MemberVo;

import lombok.Setter;

@Service
public class MemberService implements UserDetailsService {
	
	@Autowired
	@Setter
	private MemberDao mdao;
	 
	@Override
	public UserDetails loadUserByUsername(String memberId) throws UsernameNotFoundException {
		
		System.out.println("사용자 로그인 처리");
		MemberVo m = mdao.selectMember(memberId);
		System.out.println(m);
		if(m == null) {
			throw new UsernameNotFoundException(memberId);
		}
		return User.builder().username(memberId).password(m.getPassword()).roles(m.getCode_value()).build();
	}

}
