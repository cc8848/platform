package com.xmbl.ops.enumeration;

public enum EnumErrorResCode {
	//返回状态：-1：失败  0:正常   3：该教师不是学习宝用户   4：该教师已属于其他机构，不可以添加 5：该教师已被录入,可以直接加入当前机构 6：该教师第一次录入 7：该教师已存在，无须重复添加 8：机构id不存在
	SUCCESSFUL(0), SERVER_SUCCESS(2),SERVER_ERROR(-1),
	NOUSER(3), EXITIN(4),ISOUT(5),
	ONEIN(6), EXITOUT(7),NOORGANIZATION(8);

	private EnumErrorResCode(int status) {
		this.status = status;
	}

	private int status;

    public int value() {
		return status;
	}
}
