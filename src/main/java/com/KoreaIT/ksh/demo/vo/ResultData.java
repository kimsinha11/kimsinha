package com.KoreaIT.ksh.demo.vo;

import lombok.Getter;

public class ResultData<DT> {
	@Getter
	private String resultCode;
	@Getter
	private String msg;
	@Getter
	private DT data1;
	@Getter
	private String data1Name;
	@Getter
	private Object data2;
	@Getter
	private String data2Name;

	public static <DT> ResultData<DT> from(String resultCode, String msg) {
		return from(resultCode, msg, null, null);
	}

	public static <DT> ResultData<DT> from(String resultCode, String msg, String data1Name, DT data1) {
		ResultData<DT> rd = new ResultData<>();
		rd.resultCode = resultCode;
		rd.msg = msg;
		rd.data1Name = data1Name;
		rd.data1 = data1;

		return rd;
	}

	public boolean isSuccess() {
		// private boolean success한 것과 같다.
		return resultCode.startsWith("S-");
		// 출력형태 -> "success": true || false
	}

	public boolean isFail() {
		// private boolean fail한 것과 같다.
		return isSuccess() == false;
		// 출력형태 -> "fail": true || false
	}

	public static <DT> ResultData<DT> newData(ResultData<?> Rd, String data1Name, DT newData) {
		return from(Rd.getResultCode(), Rd.getMsg(), data1Name, newData);
	}

	public void setData2(String data2Name, Object data2) {
		this.data2Name = data2Name;
		this.data2 = data2;
	}
}