package com.example.demo.vo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@Setter
@Getter
@ToString 
public class ResponseDataVo {
	private String code;
	private String status;
	private String message;
	private Object item;
}

