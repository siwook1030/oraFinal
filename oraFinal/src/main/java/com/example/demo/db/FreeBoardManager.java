package com.example.demo.db;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.example.demo.vo.FreeBoardFileVo;
import com.example.demo.vo.FreeBoardVo;

public class FreeBoardManager {

	private static SqlSessionFactory sqlSessionFactory;
	
	static {
		try {
			String resource = "com/example/demo/db/sqlMapConfig.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		}catch (Exception e) {
			System.out.println("멤버오라매니저 예외 " +e.getMessage());
		}
	}
	
	public static int nextFreeBoardNum() {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.selectOne("freeBoard.nextNum");
		session.close();
		return re;
	}
	
	public static List<FreeBoardVo> listFreeBoard(){
		List<FreeBoardVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("freeBoard.selectList");
		for(FreeBoardVo f : list) {
			List<FreeBoardFileVo> file = null;
			file = session.selectList("freeBoard.selectFile", f.getNo());
			f.setFile((ArrayList<FreeBoardFileVo>) file);
		}
		session.close();
		return list;
	}
	
	public static FreeBoardVo getFreeBoard(int no) {
		FreeBoardVo f = null;
		SqlSession session = sqlSessionFactory.openSession();
		f = session.selectOne("freeBoard.selectOne", no);
		List<FreeBoardFileVo> file = null;
		file = session.selectList("freeBoard.selectFile", no);
		f.setFile((ArrayList<FreeBoardFileVo>) file);
		session.close();
		
		return f;
	}
}
