package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString 
public class RankVo {
	private String rank_name;
	private String rank_icon;
	private int min_point;
	private int max_point;
}
