package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Meeting_peopleVo {
	private String id;
	private int m_no;
	private String mp_regdate;
	private String nickName;
	private String rank_icon;
}
