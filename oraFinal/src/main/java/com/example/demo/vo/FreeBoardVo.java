package com.example.demo.vo;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString 
public class FreeBoardVo {
	
	private int no;
	private String id;
	private String nickname;
	private String title;
	private String content;
	private String regdate;
	private int hit;
	private ArrayList<FreeBoardFileVo> file;
	private MultipartFile uploadFile;
}
