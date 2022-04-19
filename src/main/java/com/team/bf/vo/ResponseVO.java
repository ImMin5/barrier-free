package com.team.bf.vo;

import java.io.Serializable;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
//직렬화 오류 가능성 warn
public class ResponseVO <T> implements Serializable{
	private int status;
	private String message;
	private T result;
	
	public ResponseVO(int statusCode, String message, T result) {
		this.status = statusCode;
		this.message = message;
		this.result = result;
	}
}
