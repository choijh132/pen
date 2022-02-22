package community;

import java.sql.Timestamp;

public class NoticeDTO {
	
	private int noticeNum;
	private Timestamp noticeReg;
	private int readCount;
	private String noticeSubject;
	private String noticeFileName;
	private String noticeContent;
	
	public int getNoticeNum() {
		return noticeNum;
	}
	public void setNoticeNum(int noticeNum) {
		this.noticeNum = noticeNum;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public String getNoticeSubject() {
		return noticeSubject;
	}
	public void setNoticeSubject(String noticeSubject) {
		this.noticeSubject = noticeSubject;
	}
	public String getNoticeFileName() {
		return noticeFileName;
	}
	public void setNoticeFileName(String noticeFileName) {
		this.noticeFileName = noticeFileName;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public Timestamp getNoticeReg() {
		return noticeReg;
	}
	public void setNoticeReg(Timestamp noticeReg) {
		this.noticeReg = noticeReg;
	}
	
}
