<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.KoreaIT.ksh.demo.vo.Member"%>
<c:set var="pageTitle" value="PROFILE" />
<%@ include file="../common/head.jspf"%>

<%
Member member = (Member) request.getAttribute("member");
int loginedMemberId = (int) request.getAttribute("loginedMemberId");
%>

<section class="mt-10 text-xl">
		<br />
		<br />
		<br />
		<div class="mx-auto overflow-x-auto">

				<table class=" table w-full table-box-type-1" style="width: 500px; text-align:center;">
						<thead>
								<tr>
										<th style="font-size: 15px">회원번호</th>
										<th>
												<div class="badge badge-lg">${member.id }</div>
										</th>
								</tr>
								<tr>
										<th style="font-size: 15px">가입날짜</th>
										<th>${member.regDate.substring(0,10) }</th>
								</tr>
								<tr>
										<th style="font-size: 15px">이름</th>
										<th>${member.name }</th>
								</tr>
								<tr>
										<th style="font-size: 15px">닉네임</th>
										<th>${member.nickname }</th>
								</tr>
								<tr>
										<th style="font-size: 15px">전화번호</th>
										<th>${member.cellphoneNum }</th>
								</tr>
								<tr>
										<th style="font-size: 15px">이메일</th>
										<th>${member.email }</th>
								</tr>

						</thead>

				</table>

		</div>
		<div class="btns">
				<%
				if (member.getId() != loginedMemberId) {
				%>
				<button class="btn-text-link btn btn-outline btn-sm" type="button" onclick="history.back()">뒤로가기</button>
				<%
				}
				%>
				<div style="text-align: center">
						<%
						if (member.getId() == loginedMemberId) {
						%>
						<button class="btn-text-link btn btn-outline btn-sm" type="button" onclick="history.back()">뒤로가기</button>
						<a class="btn-text-link btn btn-outline btn-sm" onclick="if(confirm('정말 수정하시겠습니까?') == false) return false;"
								href="../member/checkPw?id=${rq.loginedMember.id }">수정</a>
						
						<%
						}
						%>
				</div>
		</div>


</section>

<%@ include file="../common/foot.jspf"%>