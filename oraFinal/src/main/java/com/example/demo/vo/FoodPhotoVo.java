package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString 
public class FoodPhotoVo {
	private int fp_no;
	private int food_no;
	private String fp_name;
	private String fp_path;
}
