/**
 * ServiceSMSSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package kr.co.youiwe.webservice;

public interface ServiceSMSSoap extends java.rmi.Remote {
	
	public String sendSMS(java.lang.String smsID, java.lang.String hashValue, java.lang.String senderPhone, java.lang.String receivePhone, java.lang.String smsContent) throws java.rmi.RemoteException;

	public String sendSMSwnc(java.lang.String smsID, java.lang.String hashValue, java.lang.String gubun, java.lang.String senderPhone, java.lang.String receivePhone, java.lang.String smsContent) throws java.rmi.RemoteException;

	public String sendSMSReserve(java.lang.String smsID, java.lang.String hashValue, java.lang.String senderPhone, java.lang.String receivePhone, java.lang.String smsContent, java.lang.String reserveDate, java.lang.String reserveTime, java.lang.String userDefine) throws java.rmi.RemoteException;

	public String sendSMSCallBack(java.lang.String smsID, java.lang.String hashValue, java.lang.String senderPhone, java.lang.String receivePhone, java.lang.String callbackUrl, java.lang.String smsContent) throws java.rmi.RemoteException;

	public String sendSMSCallBackReserve(java.lang.String smsID, java.lang.String hashValue, java.lang.String senderPhone, java.lang.String receivePhone, java.lang.String callbackUrl, java.lang.String smsContent, java.lang.String reserveDate, java.lang.String reserveTime, java.lang.String userDefine) throws java.rmi.RemoteException;

	public int reserveCancle(java.lang.String smsID, java.lang.String hashValue, java.lang.String searchValue, java.lang.String mode) throws java.rmi.RemoteException;

	public int getRemainCount(java.lang.String smsID, java.lang.String hashValue) throws java.rmi.RemoteException;
	
	public String getRemainDay(java.lang.String smsID, java.lang.String hashValue) throws java.rmi.RemoteException;
	
	public String getWeeklyLimit(java.lang.String smsID, java.lang.String hashValue) throws java.rmi.RemoteException;
}
