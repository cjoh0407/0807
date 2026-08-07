package kr.or.oti.todo.service;

import org.modelmapper.ModelMapper;

import kr.or.oti.todo.dao.MemberDAO;
import kr.or.oti.todo.domain.MemberVO;
import kr.or.oti.todo.dto.MemberDTO;
import kr.or.oti.todo.util.MapperUtil;

public enum MemberService {
	INSTANCE;
	
	MemberDAO memberDAO = new MemberDAO(); 
	ModelMapper modelMapper = MapperUtil.INSTANCE.get();
	TodoDAO todoDAO = new TodoDAO();
	
	public MemberDTO login(String mid, String mpw) throws Exception {
		// 1. DAO에서 먼저 VO 객체를 받아옵니다.
		MemberVO vo = memberDAO.selectOne(mid);
		
		// 2. VO가 null이면(존재하지 않는 회원) 바로 null 반환
		if (vo == null) {
			return null; 
		}
		
		// 3. 존재할 때만 DTO로 변환
		MemberDTO memberDTO = modelMapper.map(vo, MemberDTO.class);
		
		// 4. 비밀번호 일치 여부 확인
		if (memberDTO.getMpw().equals(mpw)) {
			return memberDTO; 
		}
		
		return null;
	}

	public void updateUUID(String id, String uuid) throws Exception {
		memberDAO.updateUUID(id, uuid);
	}

	public MemberDTO getByUUID(String uuid) throws Exception {
		// 1. DAO에서 VO를 먼저 가져옵니다.
		MemberVO vo = memberDAO.getByUUID(uuid);
		
		// 2. 해당 UUID를 가진 회원이 없으면 null 반환 (ModelMapper 에러 방지)
		if (vo == null) {
			return null;
		}
		
		// 3. 회원이 존재할 때만 DTO로 매핑하여 반환
		return modelMapper.map(vo, MemberDTO.class);
	}
	
	public void remove(String mid) throws Exception {

	    todoDAO.deleteByMember(mid);

	    memberDAO.remove(mid);
	}

}