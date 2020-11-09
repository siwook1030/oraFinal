package com.example.demo.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MeetingVo {
	private int m_no;
	private int c_no;
	private String id;
	private String m_title;
	private String m_content;
	private String m_regdate;
	private int m_hit;
	private double m_latitude;
	private double m_longitude;
	private String m_locname;
	private Date m_time;
	private int m_numpeople;
	private String nickName;
	private String c_name;
	private String rank_icon;
}
