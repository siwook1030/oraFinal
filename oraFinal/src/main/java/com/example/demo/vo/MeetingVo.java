package com.example.demo.vo;

import java.sql.Date;
import java.util.List;

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
   private Date m_regdate;
   private int m_hit;
   private double m_latitude;
   private double m_longitude;
   private String m_locname;
   private Date m_time;
   private int m_numpeople;
   private String nickName;
   private String c_name;
   private String rank_icon;
   private List<Meeting_fileVo> mf;
   private int m_repCnt;
   private long date_diff;		// 현재시간-글등록시간
   private String date_diff_str;	// 현재시간-글등록시간을 문자열로

}
