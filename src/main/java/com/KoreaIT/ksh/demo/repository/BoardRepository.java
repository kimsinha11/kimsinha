package com.KoreaIT.ksh.demo.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.KoreaIT.ksh.demo.vo.Board;

@Mapper
public interface BoardRepository {

	@Select("""
			SELECT*FROM board
			WHERE id = #{boardId};
			
			""")
	public Board getBoardById(int boardId);

}