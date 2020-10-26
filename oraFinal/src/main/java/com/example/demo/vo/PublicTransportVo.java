package com.example.demo.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString 
public class PublicTransportVo {
	private int pt_no;
	private String code_value;
	private int c_no;
	private double pt_latitude;
	private double pt_longitude;
	private String pt_img;
	private String pt_station;
	private double pt_distance;
	private String pt_line;
	//private ArrayList<String> pt_l;
}
