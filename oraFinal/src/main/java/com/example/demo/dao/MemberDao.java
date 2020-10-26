package com.example.demo.dao;

import org.springframework.stereotype.Repository;

import com.example.demo.db.MemberManager;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.RankVo;

@Repository
public class MemberDao {
	
	public int idCheck(String id) {
		return MemberManager.idCheck(id);
	}
	public int nickCheck(String nickName) {
		return MemberManager.nickCheck(nickName);
	}
	
	public int insertMember(MemberVo m ) {
		return MemberManager.insertMember(m);
	}
	
	public MemberVo selectMember(String id) {
		return MemberManager.selectMember(id);
	}
	
	public RankVo selectRank(String rank_name) {
		return MemberManager.selectRank(rank_name);
	}
	public int updateMeber(MemberVo m ) {
		return MemberManager.updateMember(m);
	}
}