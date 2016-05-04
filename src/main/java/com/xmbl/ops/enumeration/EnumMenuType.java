package com.xmbl.ops.enumeration;

public enum EnumMenuType {
	PATH	(0, "目录"),
	MENU	(1, "菜单");

	private EnumMenuType(int id, String chineseName) {
		this.id = id;
		this.chineseName = chineseName;
	}

	private int id;
	private String chineseName;
	public int getId() {
		return id;
	}
	public String getChineseName() {
		return chineseName;
	}

}
