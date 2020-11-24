package com.example.demo.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString 
public class CourseVo {
	private int c_no;
	private String code_value;
	private String id;
	private String nickName;
	private String c_name; 
	private String c_s_locname;
	private double c_s_latitude;
	private double c_s_longitude;
	private String c_e_locname;
	private double c_e_latitude;
	private double c_e_longitude;
	private String c_loc;
	private double c_distance;
	private int c_time;
	private int c_difficulty;
	private String c_tag;
	private List<String> c_tags; // 디비에서 꺼내온 뷰를 "-" 나눠서 다시 배열로 넣기위해
	private String c_regdate;
	private String c_view;
	private String[] c_views; // 디비에서 꺼내온 뷰를 "-" 나눠서 다시 배열로 넣기위해
	private String c_words;
	private String c_line;
	private String c_temp;
	private double userDis; //코스와 유저의현재위치와의  거리
	private List<CoursePhotoVo> c_photo;
	//private List<PublicTransportVo> pt; 교통편은 경로표시를 위해 따로 뺏음
	
	

}
