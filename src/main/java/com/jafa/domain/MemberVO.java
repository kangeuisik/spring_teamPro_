package com.jafa.domain;

import lombok.Data;

@Data
public class MemberVO {

	private int mno; 
	private String id;  
	private String pwd;
	private String name;
	private int age; // <-null, 0
	private String gender;
	private String email;
	private String profile; //사진정보
	private FileType fileType;

public enum FileType{
		IMAGE, OTHER;
}
}