package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class LogVo {
	private String code_value;
	private String log_content;
	private String log_regdate;
	private int log_count;
	private String c_name;

}
