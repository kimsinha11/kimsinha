package com.KoreaIT.ksh.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.KoreaIT.ksh.demo.repository.MemberRepository;
import com.KoreaIT.ksh.demo.util.Ut;
import com.KoreaIT.ksh.demo.vo.Member;
import com.KoreaIT.ksh.demo.vo.ResultData;


@Service
public class MemberService {
	
	private MemberRepository memberRepository;

	
	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	public ResultData<Integer> join(String email, String loginPw, String name, String nickname, String cellphoneNum) {
		// 로그인 아이디 중복체크
		Member existsMember = getMemberByEmail(email);

		if (existsMember != null) {
			return ResultData.from("F-7", Ut.f("이미 사용중인 이메일(%s)입니다", email));
		}

		// 이름 + 이메일 중복체크
		existsMember = getMemberByNameAndEmail(name, email);

		if (existsMember != null) {
			return ResultData.from("F-8", Ut.f("이미 사용중인 이름(%s)과 이메일(%s)입니다", name, email));
		}

		memberRepository.join(email, loginPw, name, nickname, cellphoneNum);

		int id = memberRepository.getLastInsertId();

		return ResultData.from("S-1", "회원가입이 완료되었습니다", "id", id);
	}

	public Member getMemberByNameAndEmail(String name, String email) {
		return memberRepository.getMemberByNameAndEmail(name, email);
	}



	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}


	public int getMembersCount(String authLevel, String searchKeywordTypeCode, String searchKeyword) {
		return memberRepository.getMembersCount(authLevel, searchKeywordTypeCode, searchKeyword);
	}

	public List<Member> getForPrintMembers(String authLevel, String searchKeywordTypeCode, String searchKeyword,
			int itemsInAPage, int page) {

		int limitStart = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;
		List<Member> members = memberRepository.getForPrintMembers(authLevel, searchKeywordTypeCode, searchKeyword,
				limitStart, limitTake);

		return members;
	}

	public Member getMemberByNickname(String nickname) {
		return memberRepository.getMemberByNickname(nickname);
	}

	public Member getMemberByEmail(String email) {
		return memberRepository.getMemberByEmail(email);
	}
	public Member profile(int id) {
		return memberRepository.profile(id);
	}
	public ResultData modifyMember(int id, String loginPw, String name, String nickname, String cellphoneNum) {
		memberRepository.modifyMember(id,loginPw, name, nickname, cellphoneNum);

		Member member = getMemberById(id);

		return ResultData.from("S-1", Ut.f("%d번 회원을 수정 했습니다", id), "member", member);
	}

}