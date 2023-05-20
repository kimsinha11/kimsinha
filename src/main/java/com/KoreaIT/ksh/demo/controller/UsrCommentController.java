package com.KoreaIT.ksh.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.ksh.demo.service.BoardService;
import com.KoreaIT.ksh.demo.service.CommentService;
import com.KoreaIT.ksh.demo.util.Ut;
import com.KoreaIT.ksh.demo.vo.Board;
import com.KoreaIT.ksh.demo.vo.Comment;
import com.KoreaIT.ksh.demo.vo.ResultData;
import com.KoreaIT.ksh.demo.vo.Rq;

@Controller
public class UsrCommentController {

	@Autowired
	private CommentService commentService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private Rq rq;


	@RequestMapping("/usr/comment/cmodify")

	public String cmodify(Model model, int id, int boardId) {

		Comment comment = commentService.getComment(id);
		Board board = BoardService.getBoardById(boardId);
		
		if (comment == null) {
			return rq.jsHistoryBackOnView(Ut.f("%d번 댓글은 존재하지 않습니다", id));
		}
		if (comment.getMemberId() == rq.getLoginedMemberId()) {

			model.addAttribute("comment", comment);
			model.addAttribute("board", board);
			
			return "usr/comment/cmodify";
		} else {
			return rq.jsHistoryBackOnView(Ut.f("권한이없습니다."));
		}

	}


	@RequestMapping("/usr/comment/docModify")
	@ResponseBody
	public String docModify(int id,String body, int relId, int boardId) {

		Comment comment = commentService.getComment(id);

		if (comment == null) {
			return Ut.jsHistoryBack("F-D", id + "번 글은 존재하지 않습니다.");
		}
		if (comment.getMemberId() == rq.getLoginedMemberId()) {
			commentService.cmodifyComment(id, body);
			return Ut.jsReplace("S-1", "수정완료", Ut.f("../article/detail?id=%d&boardId=%d", relId, boardId));
		} else {
			return rq.jsHistoryBackOnView(Ut.f("권한이없습니다."));
		}

	}

	@RequestMapping("/usr/comment/docWrite")
	@ResponseBody
	public String docWrite(HttpSession httpSession, String body, int relId, int boardId) {

		if (Ut.empty(body)) {
			return Ut.jsHistoryBack("F-A", "내용을 입력해주세요");
		}

		Board board = BoardService.getBoardById(boardId);
		ResultData<Integer> writeCommentRd = commentService.cwriteComment(body, rq.getLoginedMemberId(), relId,
				boardId);
		int id = (int) writeCommentRd.getData1();
		return Ut.jsReplace("S-1", "작성완료", Ut.f("../article/detail?id=%d&boardId=%d", relId, boardId));

	}

	@RequestMapping("/usr/comment/cdelete")
	@ResponseBody
	public String docDelete(Model model, int id, int relId, int boardId) {

		Comment comment = commentService.getComment(id);
		if (comment == null) {
			return Ut.jsHistoryBack("F-D", id + "번 댓글은 존재하지 않습니다.");
		}

		if (comment.getMemberId() == rq.getLoginedMemberId()) {
			commentService.cdeleteComment(id);
			model.addAttribute("comment", comment);
			return Ut.jsReplace("S-1", "삭제완료", Ut.f("../article/detail?id=%d&boardId=%d", relId, boardId));
		} else {
			return Ut.jsHistoryBack("F-C", "권한이 없습니다.");
		}
	}

}