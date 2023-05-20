package com.KoreaIT.ksh.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.ksh.demo.vo.Comment;

@Mapper
public interface CommentRepository {

	public Comment getComment(int id);

	public void cmodifyComment(int id, String body);

	public void cwriteComment(String body, int memberId, int relId, int boardId);

	public int getLastInsertId();

	public void cdeleteComment(int id);

	public List<Comment> getComments(int id);
	

}