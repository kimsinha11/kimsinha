<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:set var="pageTitle" value="JOIN" />
<%@ include file="../common/head.jspf"%>
<!--  lodash debounce -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<br />
<br />
<br />
<script>
	let submitJoinFormDone = false;
	let validEmail ="";
	let validNickname ="";
	let validcellphoneNum ="";

	function submitJoinForm(form) {
		if (submitJoinFormDone) {
			alert('처리중입니다');
			return;
		}
		form.loginId.value = form.loginId.value.trim();
		if (form.email.value == 0) {
			alert('이메일을 입력해주세요');
			form.email.focus();
			return;
		}
		if (form.email.value != validLoginId) {
			alert('사용할 수 없는 이메일입니다');
			form.email.focus();
			return;
		}
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value == 0) {
			alert('비밀번호를 입력해주세요');
			form.loginPw.focus();
			return;
		}
		
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value == 0) {
			alert('비밀번호 확인을 입력해주세요');
			form.loginPw.focus();
			return;
		}
		if (form.loginPwConfirm.value != form.loginPw.value) {
			alert('비밀번호가 일치하지 않습니다');
			form.loginPw.focus();
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value == 0) {
			alert('이름을 입력해주세요');
			return;
		}
		form.nickname.value = validNickname;
		if (form.nickname.value == 0) {
			alert('닉네임을 입력해주세요');
			return;
		}
	
		form.cellphoneNum.value = form.validcellphoneNum.value.trim();
		if (form.cellphoneNum.value == 0) {
			alert('전화번호를 입력해주세요');
			return;
		}
	
		submitJoinFormDone = true;
		form.submit();
	}
	
	function checkEmailDup(el) {
		  $('.checkDup-msg3').empty();
		  const form = $(el).closest('form').get(0);
		  const email = form.email.value.trim();
		  if (form.email.value.length == 0) {
		    validEmail ='';
		    $('.checkDup-msg3').html('<div>이메일을 입력해주세요.</div>');
		    return;
		  }
		  if (validEmail == form.email.value) {
		    return;
		  }
		  if (email.length < 5 || email.length > 20) {
		    $('.checkDup-msg3').html('<div>5글자 ~ 20글자 사이로 입력해주세요</div>');
		    return;
		  }
		  const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		  if (!emailPattern.test(email)) {
		    $('.checkDup-msg3').html('<div>이메일 형식이 올바르지 않습니다.</div>');
		    return;
		  }
		  $.get('../member/getEmailDup', {
		    isAjax : 'Y',
		    email : email
		  }, function(data) {
		    if (form.email.value.trim() !== email) {
		      // 검사 중 입력 값이 바뀌었을 때
		      return;
		    }
		    $('.checkDup-msg3').html('<div>' + data.msg + '</div>');
		    if (data.success) {
		      validEmail = data.data1;
		    } else {
		      validEmail = '';
		    }
		  }, 'json');
		}
		const checkEmailDuplication = _.debounce(checkEmailDup, 500);


		function checkNicknameDup(el) {
			$('.checkDup-msg2').empty();
			const form = $(el).closest('form').get(0);
			const nickname = form.nickname.value.trim();
			if(form.nickname.value.length == 0) {
				validNickname ='';
				$('.checkDup-msg2').html('<div>닉네임을 입력해주세요.</div>');
				return;
			}
			if(validNickname == form.nickname.value) {
				return;
			}
			if(nickname.length < 3 || nickname.length > 20) {
				$('.checkDup-msg2').html('<div>3글자 ~ 20글자 사이로 입력해주세요</div>');
				return;
			} 
				
			$.get('../member/getNicknameDup', {
				isAjax : 'Y',
				nickname : nickname
			}, function(data) {
				if (form.nickname.value.trim() !== nickname) {
					// 검사 중 입력 값이 바뀌었을 때
					return;
				}
					
				$('.checkDup-msg2').html('<div>' + data.msg + '</div>')
				if(data.success){
					validNickname = data.data1;
				} else {
					validNickname = '';
				}
			}, 'json');
		}
		const checkNicknameDuplication = _.debounce(checkNicknameDup,500); 
		
		
			
			
			function checkPassword(el) {
			    const form = $(el).closest('form').get(0);
			    const password = form.loginPw.value.trim();
			    const confirmPassword = form.loginPwConfirm.value.trim();

			    $('.checkDup-msg5').empty();
			    $('.checkDup-msg4').empty();
			    
			    if(password.length == 0) {
			        $('.checkDup-msg5').html('<div>비밀번호를 입력해주세요.</div>');
			        return;
			    }
			    if(confirmPassword.length == 0) {
			        $('.checkDup-msg4').html('<div>비밀번호확인을 입력해주세요.</div>');
			        return;
			    }
			    
			    if (!/^(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*]).{8,}$/.test(password)) {
			        $('.checkDup-msg5').html('<div>숫자, 영어, 특수문자(!@#$%^&*)가 최소한 1개씩 포함된 8글자 이상이어야 합니다.</div>');
			        return;
			    }

			    if(password !== confirmPassword) {
			        $('.checkDup-msg4').html('<div>비밀번호가 일치하지 않습니다.</div>');
			        return;
			    }   
			}

			const checkPasswordMatch = _.debounce(checkPassword, 500);

			function checkPhoneNumber(el) {
			    const phoneNumber = el.value.trim();
			    $('.checkDup-msg6').empty();
			    
			    if(phoneNumber.length == 0) {
			    	validcellphoneNum='';
			    	$('.checkDup-msg6').html('<div>전화번호를 입력해주세요.</div>');
			        return;
			    }

			    if (!/^\d{3}-\d{3,4}-\d{4}$/.test(phoneNumber)) {
			        $('.checkDup-msg6').html('<div>올바른 전화번호 형식이 아닙니다.(000-0000-0000)</div>');
			        
			        return;
			    }
			
			}
			const checkPhoneNumberFormat = _.debounce(checkPhoneNumber, 500);


</script>
<form style="text-align: center;" method="post" onsubmit="submitJoinForm(this); return false;" action="doJoin">
		<div style="display: inline-block; border: 2px solid black; padding: 50px; width: 700px; text-align: left;">
				<div>
						이메일 :
						<input onkeyup="checkEmailDuplication(this);" class="input input-bordered input-sm w-full max-w-xs"
								style="border: 1px solid black;" value="" type="text" name="email" placeholder="이메일을 입력해주세요"
								pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" />
				</div>
				<div style="font-size: 15px; color: red;" class="checkDup-msg3"></div>
				<br />
				<div>
						비밀번호 :
						<input onkeyup="checkPassword(this);" class="input input-bordered input-sm w-full max-w-xs" type="password"
								name="loginPw" placeholder="비밀번호를 입력해주세요" pattern="^(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*]).{8,}$"
								autocomplete="off" />
				</div>
				<div style="font-size: 15px; color: red;" class="checkDup-msg5"></div>
				<br />
				<div>
						비밀번호 확인:
						<input onkeyup="checkPassword(this);" class="input input-bordered input-sm w-full max-w-xs" type="password"
								name="loginPwConfirm" placeholder="비밀번호를 입력해주세요" autocomplete="off" />
				</div>
				<div style="font-size: 15px; color: red;" class="checkDup-msg4"></div>
				<br />
				<div>
						이름 :
						<input class="input input-bordered input-sm w-full max-w-xs" type="text" name="name" placeholder="이름을 입력해주세요" />
				</div>
				<br />
				<div>
						닉네임 :
						<input onkeyup="checkNicknameDuplication(this);" class="input input-bordered input-sm w-full max-w-xs" type="text"
								name="nickname" placeholder="닉네임을 입력해주세요" id="nickname" />

				</div>
				<div style="font-size: 15px; color: red;" class="checkDup-msg2"></div>
				<br />
				<div>
						전화번호 :
						<input onkeyup="checkPhoneNumber(this);" class="input input-bordered input-sm w-full max-w-xs" value=""
								type="text" name="cellphoneNum" placeholder="전화번호를 입력해주세요" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}"
								autocomplete="off" />
				</div>
				<div style="font-size: 15px; color: red;" class="checkDup-msg6"></div>
				<br />

				<div style="text-align: center">
						<button style="display: inline; border: 1px solid black" type="submit">회원가입</button>
						<a style="display: inline; border: 1px solid black; padding: 2px 0;" href="/usr/member/login">로그인</a>
				</div>
		</div>
</form>

<%@ include file="../common/foot.jspf"%>