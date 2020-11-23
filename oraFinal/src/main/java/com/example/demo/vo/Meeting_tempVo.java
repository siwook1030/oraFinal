package com.example.demo.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Meeting_tempVo {
	private String id;
	private int c_no;
	private String m_title;
	private String m_content;
	private double m_latitude;
	private double m_longitude;
    private String m_locname;
    private Date m_time;
    private int m_numpeople;
}
