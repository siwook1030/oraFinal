package com.example.demo.db;

import java.io.InputStream;
import java.util.HashMap;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.example.demo.vo.MemberVo;
import com.example.demo.vo.PointVo;
import com.example.demo.vo.RankVo;

public class MemberManager {
	
	private static SqlSessionFactory sqlSessionFactory;
	
	static {
		try {
			String resource = "com/example/demo/db/sqlMapConfig.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		}catch (Exception e) {
			System.out.println("멤버매니저 예외 " +e.getMessage());
		}
	}
	
	
	public static int idCheck(String id) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.selectOne("member.idCheck", id);
		session.close();
		return re;
	}
	public static int nickCheck(String nickName) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.selectOne("member.nickCheck", nickName);
		session.close();
		return re;
	}
	
	public static int phoneNumCheck(String phone) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.selectOne("member.phoneNumCheck", phone);
		session.close();
		return re;
	}
	
	public static int insertMember(MemberVo m) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.insert("member.insertMember", m);
		if(re > 0) {
			session.commit();
		}
		else {
			session.rollback();
		}
		session.close();
		return re;
	}
	
	public static MemberVo selectMember(String id) {
		MemberVo m = null;
		SqlSession session = sqlSessionFactory.openSession();
		m = session.selectOne("member.selectMember", id);
		session.close();
		return m;
	}
	public static MemberVo selectMemberId(String phone) {
		MemberVo m = null;
		SqlSession session = sqlSessionFactory.openSession();
		m = session.selectOne("member.selectMemberId", phone);
		session.close();
		return m;
	}
	
	public static RankVo selectRank(String rank_name){
		RankVo vo = null;
		SqlSession session = sqlSessionFactory.openSession();
		vo = session.selectOne("member.selectRank", rank_name);
		session.close();
		return vo;
	}
	public static int updateMember(MemberVo m) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.update("member.updateMember", m);
		session.commit();
		session.close();
		return re;
	}
	public static int updatePwd(MemberVo m) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.update("member.updatePwd", m);
		session.commit();
		session.close();
		return re;
	}
	
	public static void insertPoint(PointVo p) {
		SqlSession session = sqlSessionFactory.openSession(true);
		session.insert("member.insertPoint", p);
		session.update("member.updateRank", p);
		session.close();
	}
}

