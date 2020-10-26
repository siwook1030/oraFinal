package com.example.demo.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MeetingVo {
	private int m_no;
	private int c_no;
	private String id;
	private String m_title;
	private String m_content;
	private String m_regdate;
	private int m_hit;
	private long m_latitude;
	private long m_longitude;
	private String m_locname;
	private Date m_time;
	private int m_numpeople;
	private String nickName;
	private String c_name;
	private String rank_icon;
	private Date mp_regdate; // meeting_people
}
