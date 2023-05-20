<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.KoreaIT.ksh.demo.vo.Article"%>
<%@ page import="com.KoreaIT.ksh.demo.vo.Board"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<c:set var="pageTitle" value="ARTICLE MODIFY" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<%
Article article = (Article) request.getAttribute("article");
Board board = (Board) request.getAttribute("board");
%>
<script type="text/javascript">
	let ArticleModify__submitFormDone = false;
	function ArticleModify__submit(form) {
		if (ArticleModify__submitFormDone) {
			return;
		}
		form.title.value = form.title.value.trim();
		if (form.title.value == 0) {
			alert('제목을 입력해주세요');
			return;
		}
		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();

		if (markdown.length == 0) {
			alert('내용 써라');
			editor.focus();
			return;
		}

		form.body.value = markdown;

		ArticleModify__submitFormDone = true;
		form.submit();
	}
</script>
<br />
<br />
<br />
<h1>수정하기</h1>
<hr />
<br />

<form style="text-align: left; font-size: 18px;" method="post" onsubmit="ArticleModify__submit(this); return false;" action="doModify">
		<input type="hidden" name="body" />
		<input value="${article.id }" class="input input-bordered w-full max-w-xs" type="hidden" name="id" />
		<input value="${article.boardId }" type="hidden" name="boardId" />

		<div style="display: inline-block;  text-align: left;">

				<div>작성날짜 : ${article.regDate }</div>
				<div>
						제목 :
						<input value="${article.title }" class="input input-bordered w-full max-w-xs" type="text" name="title"
								placeholder="제목을 입력해주세요" />
						<div style="text-align: right;">${rq.loginedMember.nickname }</div>
				</div>
				<div style="width: 1225px;">
						<div class="toast-ui-editor">
								<script type="text/x-template">
      </script>
						</div>
						<!--  <textarea type="text" class="input input-bordered w-full max-w-xs"  placeholder="내용을 입력해주세요" name="body" /></textarea>-->
				</div>

				<button class="btn-text-link btn btn-outline btn-xs" style="display: inline" type="submit">수정하기</button>
		</div>
</form>
<%@ include file="../common/foot.jspf"%>