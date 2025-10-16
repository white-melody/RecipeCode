package egovframework.example.auth.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.auth.service.MemberVO;

@Mapper
public interface MemberMapper {
	public MemberVO authenticate(MemberVO memberVO);
	public void register(MemberVO memberVO);
	public String findId(MemberVO memberVO);
	public MemberVO findPassword(MemberVO memberVO);
    public void updatePassword(MemberVO memberVO);
	public int isUserIdExists(MemberVO memberVO);
	public int isNicknameExists(MemberVO memberVO) throws Exception;
}
