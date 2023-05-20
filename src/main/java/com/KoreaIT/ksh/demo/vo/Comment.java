package com.KoreaIT.ksh.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comment {
	private int id;
	private String regDate;
	private String updateDate;
	private String body;
	private int memberId;
	private String name;
	private int boardId;
	private String relTypeCode;
	private int relId;

//	private boolean actorCanDelete;
	
	public String getForPrintBody() {
		return body.replaceAll("\n", "<br>");
	}
}