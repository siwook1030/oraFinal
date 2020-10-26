package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString 
public class FreeBoardFileVo {
	
	private int ff_no;
	private int no;
	private String ff_name;
	private String ff_savename;
	private double ff_size;
}
