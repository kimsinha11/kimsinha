package com.KoreaIT.ksh.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.ksh.demo.repository.BoardRepository;
import com.KoreaIT.ksh.demo.vo.Board;

@Service
public class BoardService {
	@Autowired
	private static BoardRepository boardRepository;
	
	public BoardService(BoardRepository boardRepository) {
		this.boardRepository = boardRepository;
	}
	
	public static Board getBoardById(int boardId) {

		return boardRepository.getBoardById(boardId);
	}

}