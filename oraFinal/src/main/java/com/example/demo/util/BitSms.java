package com.example.demo.util;

import org.springframework.stereotype.Repository;

import kr.co.youiwe.webservice.ServiceSMSSoapProxy;

@Repository
public class BitSms {
	
	public String sendMsg(String phoneNum, String sendMsg) {
		java.lang.String send = "";
		String smsID= "rola";	
		String smsPW="bit123400";
	
		
		ServiceSMSSoapProxy sendsms = new ServiceSMSSoapProxy();
		try{;
		String senderPhone= "010-9687-3487";
		String receivePhone= phoneNum;
		String smsContent= sendMsg;
		String test1 = (smsID+smsPW+receivePhone);
		CEncrypt encrypt = new CEncrypt("MD5",test1);
		send=sendsms.sendSMS(smsID,encrypt.getEncryptData(), senderPhone, receivePhone, smsContent);
 		System.out.println("결과코드:"+send);
		}catch(Exception e){
		System.out.println("Exception in main:" +e);
		}
		return send;
	}
}
