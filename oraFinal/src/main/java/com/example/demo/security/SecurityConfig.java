package com.example.demo.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception
	{
		// static 디렉터리의 하위 파일 목록은 인증 무시 ( = 항상통과 )
		web.ignoring().mvcMatchers("/css/**", "/js/**", "/img/**", "/lib/**");
	}
	
	@Autowired
	private CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler;

	@Autowired
	private CustomAuthenticationFailureHandler customAuthenticationFailureHandler;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
//		// TODO Auto-generated method stub
//		super.configure(http);
//		http.csrf().disable();  //post메소드시 인증필요없이하기 원래는 요청할때마다 헤더에 추가해야하지만 ...
		
		http.authorizeRequests()
		.mvcMatchers("/").permitAll()
		.mvcMatchers("/user/**").authenticated()
		.mvcMatchers("/admin/**").hasRole("00101").and() //00101 관리자
		
		
		.formLogin().loginPage("/login").successHandler(customAuthenticationSuccessHandler)
		.failureHandler(customAuthenticationFailureHandler)
		.usernameParameter("memberId")
		.passwordParameter("memberPassword")
		.permitAll();
		
		//http.exceptionHandling().authenticationEntryPoint(authenticationEntryPoint);
		
		http.logout().logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
		.logoutSuccessUrl("/mainPage").invalidateHttpSession(true).deleteCookies("JSESSIONID");
		
		http.httpBasic();
	}
	
	
}
