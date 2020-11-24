package com.example.demo.vo;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReviewVo {
	private int r_no;
	private int c_no;
	private String id;
	private String r_title;
	private String r_content;
	private Date r_regdate;
	private int r_hit;
	private String c_name;
	private String nickName;
	private String rank_icon;
	private int total_reply;	// 총 답글 수
	private long date_diff;		// 현재시간-글등록시간
	private String date_diff_str;	// 현재시간-글등록시간을 문자열로
	private List<Review_fileVo> rf;
}
