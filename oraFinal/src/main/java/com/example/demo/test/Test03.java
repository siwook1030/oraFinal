package com.example.demo.test;

import java.sql.Date;
import java.time.LocalDate;

import com.example.demo.dao.ReviewDao;
import com.example.demo.vo.ReviewVo;

public class Test03 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ReviewDao dao = new ReviewDao();
		ReviewVo vo = dao.selectOne(149);
		Date date = vo.getR_regdate();
		
		System.out.println(date.toString());
		
		
	}

}
