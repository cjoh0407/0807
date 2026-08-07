package kr.or.oti.todo.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;

import kr.or.oti.todo.dao.TodoDAO;
import kr.or.oti.todo.domain.TodoVO;
import kr.or.oti.todo.dto.TodoDTO;
import kr.or.oti.todo.util.MapperUtil;

public enum TodoService {
	INSTANCE;
	
	TodoDAO todoDAO = new TodoDAO(); 
	ModelMapper modelMapper = MapperUtil.INSTANCE.get();
	
	public void register(TodoDTO todoDTO) throws Exception {
		todoDAO.insertOne(modelMapper.map(todoDTO, TodoVO.class));
		System.out.println("DEBUG..." + todoDTO);
	}
	
	public List<TodoDTO> getList() throws Exception {
		List<TodoVO> list = todoDAO.selectAll();
		return list.stream().map(todoVO -> modelMapper.map(todoVO, TodoDTO.class)).toList();
	}
	
	public TodoDTO get(long tid) throws Exception {
		return modelMapper.map(todoDAO.selectOne(tid), TodoDTO.class);
	}

	public void remove(long tid) throws Exception {
		todoDAO.deleteOne(tid);
	}

	public void modify(TodoDTO todoDTO) throws Exception {
		todoDAO.updateOne(modelMapper.map(todoDTO, TodoVO.class));
	}

}
