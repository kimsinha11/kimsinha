package com.KoreaIT.ksh.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.ksh.demo.repository.CommentRepository;
import com.KoreaIT.ksh.demo.util.Ut;
import com.KoreaIT.ksh.demo.vo.Comment;
import com.KoreaIT.ksh.demo.vo.ResultData;

@Service
public class CommentService {
	@Autowired
	private CommentRepository commentRepository;

	public CommentService(CommentRepository commentRepository) {
		this.commentRepository = commentRepository;
	}

	public Comment getComment(int id) {
		return commentRepository.getComment(id);
	}

	public ResultData cmodifyComment(int id, String body) {
		commentRepository.cmodifyComment(id, body);

		Comment comment = getComment(id);

		return ResultData.from("S-1", Ut.f("%d번 댓글을 수정 했습니다", id), "comment", comment);
		
	}

	public ResultData<Integer> cwriteComment(String body, int memberId, int relId, int boardId) {
		commentRepository.cwriteComment(body, memberId, relId, boardId);

		int id = commentRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 댓글이 생성되었습니다", id), "id", id);

	}

	public void cdeleteComment(int id) {
		commentRepository.cdeleteComment(id);
		
	}

	public List<Comment> getComments(int id) {
		return commentRepository.getComments(id);
	}
	

}