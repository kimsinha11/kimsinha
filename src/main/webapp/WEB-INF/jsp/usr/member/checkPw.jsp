<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.KoreaIT.ksh.demo.vo.Member"%>
<c:set var="pageTitle" value="Pw check" />
<%@ include file="../common/head.jspf"%>
<%@ page import="com.KoreaIT.ksh.demo.vo.Rq"%>



<%
Member member = (Member) request.getAttribute("member");
String loginPw = member.getLoginPw();
%>
<h1 style="text-align: center; padding: 70px 20px 0;">비밀번호 확인</h1>

<script>
let checkPw__submitFormDone = false;
function checkPw__submitForm(form) {
	if (checkPw__submitFormDone) {
		return;
	}
	form.loginPw.value = form.loginPw.value.trim();

	if(form.loginPw.value.length == 0){
			alert('비밀번호를 입력해주세요');
			form.loginPw.focus();
			return;
	}
	if (form.loginPw.value !== '<%= loginPw %>') {
				alert('비밀번호가 일치하지 않습니다');
				form.loginPw.focus();
				return;
			}	

	checkPw__submitFormDone = true;
	form.submit();
}
</script>

<form action="doCheckPw" style="text-align: center;" method="post" onsubmit="checkPw__submitForm(this); return false;" >
<div  style="display: inline-block;  border: 2px solid black; padding: 17px; text-align:left;">

	<div>
		이메일 : <input value="${rq.loginedMember.email}" type="text" name="email" />
	</div>
	<div>
		비밀번호 : <input class="input input-bordered input-sm w-full max-w-xs" type="text" name="loginPw"
			placeholder="비밀번호를 입력해주세요" />
	</div>

<br />
<div style="text-align: center">
<button class="btn-text-link btn btn-outline btn-xs" style="display: inline;" type="submit"> 확인</button>
	</div>
</div>
</form>
<%@ include file="../common/foot.jspf"%>