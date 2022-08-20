package com.service.tac.model.vo;

public class Member {
	private String memberId; // member_id
	private String password;
	private String name;
	private int age;
	private String phone;
	private String grade; // 관리자 사용자 구분을 위한 컬럼
	private int consumeId; // consume_id 객체로 변경 예정
	private int cardId; // card_id 객체로 변경 예정

	public Member() {
		super();
	}

	public Member(String memberId, String password, String name, int age, String phone, String grade, int consumeId,
			int cardId) {
		super();
		this.memberId = memberId;
		this.password = password;
		this.name = name;
		this.age = age;
		this.phone = phone;
		this.grade = grade;
		this.consumeId = consumeId;
		this.cardId = cardId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public int getConsumeId() {
		return consumeId;
	}

	public void setConsumeId(int consumeId) {
		this.consumeId = consumeId;
	}

	public int getCardId() {
		return cardId;
	}

	public void setCardId(int cardId) {
		this.cardId = cardId;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", password=" + password + ", name=" + name + ", age=" + age
				+ ", phone=" + phone + ", grade=" + grade + ", consumeId=" + consumeId + ", cardId=" + cardId + "]";
	}

}
