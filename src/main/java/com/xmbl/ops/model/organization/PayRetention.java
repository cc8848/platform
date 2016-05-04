package com.xmbl.ops.model.organization;

import java.util.Date;

import lombok.Data;
@Data
public class PayRetention {
    private Date createtime;

    private Long gameid;

    private Long gameserverid;

    private Long platformid;
	
	private Long fispu;

    private Long oneDayRetained;

    private Long twoDayRetained;

    private Long threeDayRetained;

    private Long fourDayRetained;

    private Long fiveDayRetained;

    private Long sixDayRetained;

    private Long sevenDayRetained;

    private Long tenDayRetained;

    private Long fifteenDayRetained;

    private Long thirtyDayRetained;

    private Date updatetime;

}