<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:set var="pageTitle" value="LOGIN" />
<%@ include file="../common/head.jspf"%>

<br />
<br />
<br />


<form style="text-align: center;" method="post" action="doLogin">
		<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri }" />
		<div style="display: inline-block; border: 2px solid black; padding: 100px; text-align: left;">

				<div>
						아이디 :
						<input class="input input-bordered input-sm w-full max-w-xl" style=" border:1px solid black;" type="text" name="loginId" placeholder="아이디를 입력해주세요" />
				</div>
				<div>
						비밀번호 :
						<input class="input input-bordered input-sm w-full max-w-xl" style="border:1px solid black;" type="text" name="loginPw" placeholder="비밀번호를 입력해주세요"
								autocomplete="off" />
				</div>

				<br />
				
				<div style="text-align: center">
						<button  style="display: inline; border:1px solid black;" type="submit">로그인</button>
						<a style="padding:2px 0; border:1px solid black;" href="/usr/member/join">회원가입</a>

				</div>
		</div>
</form>

<%@ include file="../common/foot.jspf"%>