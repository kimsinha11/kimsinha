<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.KoreaIT.ksh.demo.vo.Article"%>
<%@ page import="com.KoreaIT.ksh.demo.vo.Board"%>
<c:set var="pageTitle" value="DETAIL" />
<%@ include file="../common/head.jspf"%>
<%@ page import="com.KoreaIT.ksh.demo.vo.Comment"%>
<%
Comment comment = (Comment) request.getAttribute("comment");
%>

<!-- <iframe src="http://localhost:8081/usr/article/doIncreaseHitCountRd?id=2" frameborder="0"></iframe> -->
<!-- 변수 생성 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
	params.memberId = parseInt('${loginedMemberId}');
	var isAlreadyAddGoodRp = ${isAlreadyAddGoodRp};
	var isAlreadyAddBadRp = ${isAlreadyAddBadRp};
</script>

<!-- 메서드 생성 -->
<script>
	function ArticleDetail__increaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyView';
		
		if(localStorage.getItem(localStorageKey)) {
			return;
		}
		
		localStorage.setItem(localStorageKey, true);
		
		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}
	$(function() {
		// 실전코드
		 	ArticleDetail__increaseHitCount();
		// 연습코드
		//setTimeout(ArticleDetail__increaseHitCount, 2000);
	})


</script>
<!-- 댓글 리액션 실행 코드 -->



<script type="text/javascript">
	let ReplyWrite__submitFormDone = false;
	function ReplyWrite__submitForm(form) {
		if (ReplyWrite__submitFormDone) {
			return;
		}
		form.body.value = form.body.value.trim();
		if (form.body.value.length < 3) {
			alert('3글자 이상 입력하세요');
			form.body.focus();
			return;
		}
		ReplyWrite__submitFormDone = true;
		form.submit();
	}
</script>
<%
Article article = (Article) request.getAttribute("article");
int loginedMemberId = (int) request.getAttribute("loginedMemberId");

Board board = (Board) request.getAttribute("board");
%>
	<br /><br /><br />
<section class="mt-10 text-xl">
	<div class="mx-auto overflow-x-auto">
		<table class=" table w-full table-box-type-1"
			style="width: 700px; height: 300px;">
			<thead>
				<tr>
					<th style="font-size: 15px">번호</th>
					<th>
						<div class="badge badge-lg">${article.id }</div>
					</th>
				</tr>
				<tr>
				<th style="font-size: 15px">게시판</th>
				<th>${board.name }</th>
				</tr>
				<tr>
					<th style="font-size: 15px">작성날짜</th>
					<th>${article.regDate.substring(0,10) }</th>
				</tr>
				<tr>
					<th style="font-size: 15px">수정날짜</th>
					<th>${article.updateDate.substring(0,10) }</th>
				</tr>
				<tr>
					<th style="font-size: 15px">작성자</th>
					<th>${article.name }</th>
				</tr>
				<tr>
					<th style="font-size: 15px">제목</th>
					<th>${article.title }</th>
				</tr>
				<tr>
					<th style="font-size: 15px">내용</th>
					<th>${article.body }</th>
				</tr>
				<tr>
					<th style="font-size: 15px">조회수</th>
					<th><span class="article-detail__hit-count">${article.hitCount }</span>
					</th>
				</tr>

			</thead>

		</table>

	</div>
	<div class="btns">
		<div style="text-align: center">
			<%
			if (article.getMemberId() != loginedMemberId) {
			%>
			<button class="btn-text-link btn btn-outline btn-xs" type="button"
				onclick="history.back()">뒤로가기</button>
			<%
			}
			%>



		</div>
		<div style="text-align: center">
			<%
			if (article.getMemberId() == loginedMemberId) {
			%>
			<button class="btn-text-link btn btn-outline btn-xs" type="button"
				onclick="location.href='list'">뒤로가기</button>
			<a class="btn-text-link btn btn-outline btn-xs"
				onclick="if(confirm('정말 수정하시겠습니까?') == false) return false;"
				href="modify?id=${article.id }&boardId=${article.boardId}">수정</a> <a
				class="btn-text-link btn btn-outline btn-xs"
				onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
				href="delete?id=${article.id }&boardId=${article.boardId}">삭제</a>
			<%
			}
			%>
		</div>
	</div>

</section>
<c:if test="${rq.logined }">
	<form style="text-align: center;" action="../comment/docWrite"
		method="POST" onsubmit="ReplyWrite__submitForm(this); return false;">

		<div
			style="display: inline-block; border: 2px solid black; width: 700px; height: 100px; text-align: left;">
			<div style="display: none">

				<input value="${article.id }"
					class="input input-bordered w-full max-w-xs" type="hidden"
					name="relId" /> <input type="hidden" name="relTypeCode"
					value="article" /> <input value="${article.boardId }"
					class="input input-bordered w-full max-w-xs" type="hidden"
					name="boardId" />

			</div>

			<div>작성자 : ${rq.loginedMember.nickname}</div>
			<div>
				내용 :
				<textarea type="text" class="input input-bordered w-full max-w-xs"
					placeholder="내용을 입력해주세요" name="body" /></textarea>
				<button class="btn-text-link btn btn-outline btn-xs"
					style="display: inline" type="submit">작성하기</button>
			</div>


		</div>
	</form>
</c:if>
<div style="text-align: center;">
	<c:if test="${rq.notLogined }">
		<a class="btn-text-link btn btn-outline btn-xs" type="button"
			href="${rq.loginUri }">로그인</a> 후 댓글 작성을 이용해주세요
</c:if>
</div>
<br />
<div style="text-align: center;">댓글 리스트</div>
<table class="table-box-type-2 table w-full"
	style="border-collaspe: collaspe; width: 700px;">
	<thead>

		<tr>
			<th style="font-size: 19px">내용</th>
			<th style="font-size: 19px">날짜</th>
			<th style="font-size: 19px">작성자</th>
			<th style="font-size: 19px">수정</th>
			<th style="font-size: 19px">삭제</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="comment" items="${comments }">
			<tr>
				<th>${comment.body }</th>
				<th>${comment.regDate.substring(0,10) }</th>
				<th>${comment.name}</th>

				<th><a class="btn-text-link btn btn-outline btn-xs"
					onclick="if(confirm('정말 수정하시겠습니까?') == false) return false;"
					href="../comment/cmodify?id=${comment.id }&relId=${comment.relId }&boardId=${board.id}">수정</a>
				</th>
				<th><a class="btn-text-link btn btn-outline btn-xs"
					onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
					href="../comment/cdelete?id=${comment.id }&relId=${comment.relId }&boardId=${board.id}">삭제</a>
				</th>

			</tr>
		</c:forEach>
	</tbody>
</table>




<%@ include file="../common/foot.jspf"%>