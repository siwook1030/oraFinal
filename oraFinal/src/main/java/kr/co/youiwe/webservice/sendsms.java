package kr.co.youiwe.webservice;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;
import javax.xml.namespace.QName;
import javax.xml.rpc.ServiceException;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service; 

//public class sendsms {
//
//	/**
//	 * @param args
//	 */
//	public static void main(String[] args) {
//		
//
//		BufferedReader in;
//	    in = new BufferedReader(new InputStreamReader(System.in));
//
//		String smsID= "rola";	
//		String smsPW="bit123400";
//	
//		
//		ServiceSMSSoapProxy sendsms = new ServiceSMSSoapProxy();
//		try{
//		System.out.println("보내는번호를 입력하세요:");
//		String senderPhone= in.readLine();
//		System.out.println("받는번호를 입력하세요:");
//		String receivePhone= in.readLine();
//		System.out.println("내용을를 입력하세요:");
//		String smsContent= in.readLine();
//		String test1 = (smsID+smsPW+receivePhone);
//		CEncrypt encrypt = new CEncrypt("MD5",test1);
//		java.lang.String send=sendsms.sendSMS(smsID,encrypt.getEncryptData(), senderPhone, receivePhone, smsContent);
// 		System.out.println("결과코드:"+send);
//		}catch(Exception e){
//		System.out.println("Exception in main:" +e);
//		}
//	}
//}


  
//class CEncrypt
//{
//    MessageDigest md;
//    String strSRCData = "";
//    String strENCData = "";
//
//    public CEncrypt(){}
//    //인스턴스 만들 때 한방에 처리할 수 있도록 생성자 중복시켰습니다. 
//    public CEncrypt(String EncMthd, String strData)
//    {
//        this.encrypt(EncMthd, strData);
//    }
//
//    //암호화 절차를 수행하는 메소드입니다.
//    public void encrypt(String EncMthd, String strData)
//   {
//       try
//      {
//          MessageDigest md = MessageDigest.getInstance(EncMthd); // "MD5" or "SHA1"
//         byte[] bytData = strData.getBytes();
//         md.update(bytData);
//
//         byte[] digest = md.digest();
//         StringBuffer sb = new StringBuffer();
//         for(int i =0;i<digest.length;i++)
//         {
//        	 strENCData = sb.append(Integer.toString((digest[i]&0xff) + 0x100, 16).substring(1)).toString();
//         }
//       }catch(NoSuchAlgorithmException e)
//      {
//         System.out.print("암호화 알고리즘이 없습니다.");
//      };
//    
//      //나중에 원본 데이터가 필요할지 몰라서 저장해 둡니다.
//      strSRCData = strData;
//    }
//
//    //접근자 인라인 함수(아니, 메소드)들입니다.
//    public String getEncryptData(){return strENCData;}
//    public String getSourceData(){return strSRCData;}
//
//    //데이터가 같은지 비교해주는 메소드입니다.
//    public boolean equal(String strData)
//    {
//      //암호화 데이터랑 비교를 하던, 원본이랑 비교를 하던 맘대로....
//      if(strData == strENCData) return true;
//      return false;
//    }
//	
//}
