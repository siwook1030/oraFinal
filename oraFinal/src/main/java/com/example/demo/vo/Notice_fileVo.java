package com.example.demo.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Notice_fileVo {

	private int nf_no;
	private int n_no;
	private String nf_name;
	private String nf_savename;
	private String nf_path;
	private long rf_size;
	private MultipartFile uploadFile;
}
