package com.example.demo.test;

import com.example.demo.dao.MeetingDao;
import com.example.demo.vo.Meeting_tempVo;

public class Test07 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		MeetingDao mdao = new MeetingDao();
		Meeting_tempVo mtvo = mdao.selectTemp("test1234");
		System.out.println(mtvo.getC_no()); // 0
		System.out.println(mtvo.getM_title());
	}

}
