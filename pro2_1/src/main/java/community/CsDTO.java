package community;

import java.sql.Timestamp;

public class CsDTO {
	
	private	int num;
	private String writer;
	private String subject;
	private String fileName;
	private String content;
	private int ref; //게시글 고유번호를 참고하는 답글 참고용
	private int re_lev; //들여쓰기 여부용(답글) //잠만.. 이거 쓸 필요 없는거 아님?
	private String csLock; //잠금 여부 (관리자와 작성자만 볼 수 있게)
	private int groupNum; //그룹넘 지정, 정렬을 위해서 추가
	private Timestamp csDate;

	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}
	public String getCsLock() {
		return csLock;
	}
	public void setCsLock(String csLock) {
		this.csLock = csLock;
	}
	public int getGroupNum() {
		return groupNum;
	}
	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}
	public Timestamp getCsDate() {
		return csDate;
	}
	public void setCsDate(Timestamp csDate) {
		this.csDate = csDate;
	}
}
