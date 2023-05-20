package com.KoreaIT.ksh.demo.vo;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.KoreaIT.ksh.demo.service.MemberService;
import com.KoreaIT.ksh.demo.util.Ut;

import lombok.Getter;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Rq {
	@Getter
	private boolean isLogined;
	@Getter
	private int loginedMemberId;
	@Getter
	private Member loginedMember;
	private HttpServletRequest req;
	private HttpServletResponse resp;
	private HttpSession session;
	
	private Map<String, String> paramMap;
	
	public Rq(HttpServletRequest req, HttpServletResponse resp, MemberService memberService) {
		this.req = req;
		this.resp = resp;
		this.session = req.getSession();
		
		paramMap = Ut.getParamMap(req);
		
		boolean isLogined = false;
		int loginedMemberId = 0;
		Member loginedMember = null;
		
		if (session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
			loginedMember = memberService.getMemberById(loginedMemberId);
		}

		this.isLogined = isLogined;
		this.loginedMemberId = loginedMemberId;
		this.loginedMember = loginedMember;
		this.req.setAttribute("rq", this);
	}

	public void printHitoryBackJs(String msg) throws IOException {

		resp.setContentType("text/html; charset=UTF-8");
		println("<script>");
		if (!Ut.empty(msg)) {
			println("alert('" + msg + "');");
		}
		println("history.back();");
		println("</script>");
	}
	
	public void printLoginBackJs(String msg) throws IOException {
		resp.setContentType("text/html; charset=UTF-8");
		println("<script>");
		if (!Ut.empty(msg)) {
			println("alert('" + msg + "');");
		}
		println("location.href='../member/login';");
		println("</script>");
	}

	public void print(String str) {
		try {
			resp.getWriter().append(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void println(String str) {
		print(str + "\n");
	}

	public void login(Member member) {
		session.setAttribute("loginedMemberId", member.getId());

	}

	public void logout() {
		session.removeAttribute("loginedMemberId");
		
	}
	

	public String jsHistoryBackOnView(String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "usr/common/common";

	}

	public String jsHistoryBack(String resultCode, String msg) {
		return Ut.jsHistoryBack(resultCode, msg);
	}

	public String jsReplace(String msg, String uri) {
		return Ut.jsReplace(msg, uri);
	}

	public String getCurrentUri() {
		String currentUri = req.getRequestURI();
		String queryString = req.getQueryString();
		
		System.out.println(currentUri);
		System.out.println(queryString);
		
		if (queryString != null && queryString.length() > 0) {
			currentUri += "?" + queryString;
		}

		System.out.println(currentUri);
		return currentUri;

	}
	
	public String getLoginUri() {
		return "../member/login?afterLoginUri=" + getAfterLoginUri();
	}
	public String getLogoutUri() {
		return "../member/logout?afterLogoutUri=" + getAfterLogoutUri();
	}
	public String getJoinUri() {
		return "../member/join?afterLoginUri=" + getAfterLoginUri();
	}
	
	//로그인 후 접근 불가 페이지 afterLoginUri 값이 유지되도록
	private String getAfterLoginUri() {
		String requestUri = req.getRequestURI();
		switch(requestUri) {
		case "/usr/member/login":
		case "/usr/member/join":
			return Ut.getEncodedUri(paramMap.get("afterLoginUri"));
		}
		return getEncodedCurrentUri();
	}
	//로그인 후 접근 불가 페이지 afterLogoutUri 값이 유지되도록
	private String getAfterLogoutUri() {
	//	String requestUri = req.getRequestURI();
		return getEncodedCurrentUri();
	}
	
	public String getEncodedCurrentUri() {
		return Ut.getEncodedCurrentUri(getCurrentUri());
	}
	
	
	// Rq 객체 생성 유도
	// 삭제 x, BeforeActionInterceptor 에서 강제 호출
	public void initOnBeforeActionInterceptor() {

	}

	public boolean isNotLogined() {
		return !isLogined;
	}

	public void run() {
		System.out.println("===================================A");
	}

	public void jsprintReplace(String msg, String replaceUri) {
		resp.setContentType("text/html; charset=UTF-8");
		print(Ut.jsReplace(msg, replaceUri));

	}


	private String getAfterFindLoginIdUri() {
		return getEncodedCurrentUri();
	}

	public String getFindLoginPwUri() {
		return "../member/findLoginPw?afterFindLoginPwUri=" + getAfterFindLoginPwUri();
	}

	private String getAfterFindLoginPwUri() {
		return getEncodedCurrentUri();
	}
	

	public boolean isAdmin() {
		if (isLogined == false) {
			return false;
		}

		return loginedMember.isAdmin();
	}

}