package kr.or.oti.todo.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;

import kr.or.oti.todo.dao.MemberDAO;
import kr.or.oti.todo.dao.TodoDAO;
import kr.or.oti.todo.domain.TodoVO;
import kr.or.oti.todo.dto.MemberDTO;
import kr.or.oti.todo.dto.TodoDTO;
import kr.or.oti.todo.util.MapperUtil;

public enum MemberService {
	INSTANCE;
	
	MemberDAO memberDAO = new MemberDAO(); 
	ModelMapper modelMapper = MapperUtil.INSTANCE.get();
	
	public MemberDTO login(String mid, String mpw) throws Exception {
		MemberDTO memberDTO = modelMapper.map(memberDAO.selectOne(mid), MemberDTO.class);
		if (memberDTO == null) {
			return null; 
		}
		
		if (memberDTO.getMpw().equals(mpw)) {
			return memberDTO; 
		}
		
		return null;
	}

	public void updateUUID(String id, String uuid) throws Exception {
		memberDAO.updateUUID(id, uuid);
	}

	public MemberDTO getByUUID(String uuid) {
		try {
			return modelMapper.map(memberDAO.getByUUID(uuid), MemberDTO.class);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
