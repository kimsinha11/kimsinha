<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.KoreaIT.ksh.demo.vo.Member"%>
<c:set var="pageTitle" value="PROFILE" />
<%@ include file="../common/head.jspf"%>

<%
Member member = (Member) request.getAttribute("member");

%>

<script>
let MemberModify__submitFormDone = false;
function MemberModify__submit(form) {
	if (MemberModify__submitFormDone) {
		return;
	}
	form.loginPw.value = form.loginPw.value.trim();
	if (form.loginPw.value.length > 0) {
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value.length == 0) {
			alert('비밀번호 확인란을 입력해주세요');
			form.loginPwConfirm.focus();
			return;
		}
		if (form.loginPw.value != form.loginPwConfirm.value) {
			alert('비밀번호가 일치하지 않습니다');
			form.loginPw.focus();
			return;
		}
	}
	form.name.value = form.name.value.trim();
	form.nickname.value = form.nickname.value.trim();
	form.cellphoneNum.value = form.cellphoneNum.value.trim();
	form.email.value = form.email.value.trim();
	if (form.name.value.length == 0) {
		alert('이름을 입력해주세요');
		form.name.focus();
		return;
	}
	if (form.nickname.value.length == 0) {
		alert('닉네임을 입력해주세요');
		form.nickname.focus();
		return;
	}
	if (form.cellphoneNum.value.length == 0) {
		alert('전화번호를 입력해주세요');
		form.cellphoneNum.focus();
		return;
	}
	
	MemberModify__submitFormDone = true;
	form.submit();
}
</script>
	<br /><br /><br />
<form  action="domModify" style="text-align: center;" method="post" onsubmit="MemberModify__submit(this); return false;">
<div  style="display: inline-block;  border: 2px solid black; padding: 17px; text-align:left;">
	<div>
		회원번호 : <input value="${member.id }" class="input input-bordered w-full max-w-xs"  type="hidden" name="id"
			/>  ${member.id }
	</div>
	<div>가입날짜 : ${member.regDate }</div>
	<div>이메일 : ${member.email }</div>
	<div>
		새 비밀번호 : <input value="${member.loginPw }" class="input input-bordered w-full max-w-xs"  type="text" name="loginPw"
			placeholder="변경할 비밀번호를 입력해주세요" />
	</div>
	<div>
		비밀번호 확인: <input value="${member.loginPw }" class="input input-bordered w-full max-w-xs"  type="text" name="loginPwConfirm"
			placeholder="변경할 비밀번호를 입력해주세요" />
	</div>
	<div>
		이름 : <input value="${member.name }" class="input input-bordered w-full max-w-xs"  type="text" name="name"
			placeholder="변경할 이름을 입력해주세요" />
	</div>
	<div>
		닉네임 : <input value="${member.nickname }" class="input input-bordered w-full max-w-xs"  type="text" name="nickname"
			placeholder="변경할 닉네임을 입력해주세요" />
	</div>
	<div>
		전화번호 : <input value="${member.cellphoneNum }" class="input input-bordered w-full max-w-xs"  type="text" name="cellphoneNum"
			placeholder="변경할 전화번호를 입력해주세요" />
	</div>


	<button class="btn-text-link btn btn-outline btn-xs" style="display: inline" type="submit"> 수정하기</button>
		</div>
</form>

<%@ include file="../common/foot.jspf"%>