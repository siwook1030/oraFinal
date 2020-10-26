package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString 
public class CoursePhotoVo {
	private int cp_no;
	private int c_no;
	private String cp_name;
	private String cp_path;
	private double cp_latitude;
	private double cp_longitude;
}
