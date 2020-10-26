package com.example.demo.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString 
public class FoodVo {
	private int food_no;
	private int c_no;
	private String food_tag; 
	private String food_tel;
	private String food_name;
	private String food_addr;
	private String food_bhours;
	private List<FoodPhotoVo> food_photo;
}
