package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MemberVo {
	
	private String id;
	private String code_value;
	private String password;
	private String name;
	private String nickName;
	private String phone;
	private String gender;
	private String rank_name;
	private String regdate;
}
