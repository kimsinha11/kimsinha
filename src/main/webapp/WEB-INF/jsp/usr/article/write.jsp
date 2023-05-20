<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.KoreaIT.ksh.demo.vo.Article"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<c:set var="pageTitle" value="ARTICLE WRITE" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>

<script type="text/javascript">
	let ArticleWrite__submitFormDone = false;
	function ArticleWrite__submit(form) {
		if (ArticleWrite__submitFormDone) {
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

		ArticleWrite__submitFormDone = true;
		form.submit();
	}
</script>

<%
Article article = (Article) request.getAttribute("article");
%>
<br />
<br />
<br />

<h1>글작성하기</h1>
<hr />
<br />

<form style="text-align: left;" enctype="multipart/form-data" method="post"
		onsubmit="ArticleWrite__submit(this); return false;" action="doWrite">
		<input type="hidden" name="body" />

		<div>
				<select class="select select-bordered w-full max-w-xs" name="category" onchange="categoryChange(this)">
						<option disabled selected>게시판 선택</option>
						<option value="etc">기타글</option>
					
				</select>
				<select class="select select-bordered w-full max-w-xs" name="boardId" id="board-select" disabled>
						<option disabled selected>게시판 선택</option>
				</select>
		</div>
	
		<script>
			function categoryChange(select) {
				var boardSelect = document.getElementById("board-select");
				boardSelect.innerHTML = '<option disabled selected>게시판 선택</option>';
				boardSelect.disabled = false;
				if (select.value == "etc") {
					boardSelect.innerHTML += '<option value="1">Notice</option>';
					boardSelect.innerHTML += '<option value="2">Free</option>';
					boardSelect.innerHTML += '<option value="3">QnA</option>';
				} 
			}
		</script>
		<br />
		<div style="text-align: left;">
				제목 :
				<input value="${article.title }" class="input input-bordered w-full max-w-xs" type="text" name="title"
						placeholder="제목을 입력해주세요" />
				<div style="text-align: right;">${rq.loginedMember.nickname }</div>
		</div>
		<div>

				<div class="toast-ui-editor">
						<script type="text/x-template">
      </script>
				</div>
				<!--  <textarea type="text" class="input input-bordered w-full max-w-xs"  placeholder="내용을 입력해주세요" name="body" /></textarea>-->
		</div>

		<button class="btn-text-link btn btn-outline btn-xs" style="display: inline" type="submit">작성하기</button>


		<script>
			const boardSelect = document.getElementsByName("boardId")[0];
			const boardIdInput = document.getElementsByName("boardId")[0];
			boardSelect.onchange = function() {
				var selectedValue = boardSelect.value;
				boardIdInput.value = selectedValue;
			}
		</script>


</form>

<%@ include file="../common/foot.jspf"%>