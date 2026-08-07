package kr.or.oti.todo.domain;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class TodoVO {
	private String mid;
	private Long tid;
	private String title;
	private LocalDate dueDate;
	private boolean finished;
}
