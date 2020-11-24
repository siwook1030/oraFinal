package com.example.demo.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class NoticeVo {

	private int n_no;
	private String code_value;
	private String code_name;
	private String n_title;
	private String n_content;
	private String n_regdate;
	private int n_hit;
	private String n_file;
	private MultipartFile uploadFile;
}

