package com.example.demo.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Meeting_fileVo {
	private int mf_no;
	private int m_no;
	private String mf_name;
	private String mf_savename;
	private String mf_path;
	private long mf_size;
	private MultipartFile uploadFile;
	
}
