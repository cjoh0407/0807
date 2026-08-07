package kr.or.oti.todo.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class TodoDTO {
	private Long tid;
	private String title;
	private LocalDate dueDate;
	private boolean finished;
	
	public String getFinishedStr() {
		return finished ? "done" : "not yet";
	}
	
//	public TodoVO getTodoVO() {
//		return TodoVO.builder()
//				.tid(tid)
//				.title(title)
//				.dueDate(dueDate)
//				.finished(finished)
//				.build();
//	}
}
