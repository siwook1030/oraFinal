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
	private String code; // 성공실패 코드
	private String status;
	private String message; // 등록에 성공했는지 실패했는지 메세지
	private Object item; // map으로 받아올 수 있음
}

