package com.example.demo.test;

import com.example.demo.dao.ReviewDao;
import com.example.demo.vo.ReviewVo;

// 정재호
public class Test02 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ReviewDao dao = new ReviewDao();
		for(int i = 100; i < 150; i++) {
			ReviewVo vo = new ReviewVo();
			vo.setR_no(i);
			vo.setC_no(1);
			vo.setId("hoja2242");
			vo.setR_title("페이지테스트");
			vo.setR_content("페이지테스트중입니다. 감사합니다.");
			dao.insert(vo);
		}
	}

}
