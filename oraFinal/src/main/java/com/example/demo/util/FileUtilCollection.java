package com.example.demo.util;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

public class FileUtilCollection {
	
	public static String filePrefixName() {     // 파일저장시 중복된 이름을 피하기 위해 접두어 생성 메소드
		String fileName = "";
		SimpleDateFormat today = new SimpleDateFormat("yyyyMMdd"); // 현재시간 생성 ex) 20201107
		UUID uuid = UUID.randomUUID(); //  랜덤으로 문자열을 생성
		fileName = today.format(new Date())+"_"+uuid.toString();
		
		return fileName;
	}
	
	public static void saveImage(MultipartFile mf, String path) { // 이미지 저장 메소드 (멀티파트파일과 경로를 매개변수로 받음)
		try {
			mf.transferTo(new File(path));
		}catch (Exception e) {
			System.out.println("파일유틸컬렉션 세이브이미지 예외 "+ e.getMessage());
		}
	}
	
	public static void saveText(String text, String path) {  // 텍스트 저장 메소드 (스트링 텍스트와 경로를 매개변수로 받음)
		try {
			 BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(path, false));
			 bufferedWriter.write(text);
			 bufferedWriter.flush();
			 bufferedWriter.close();
		}catch (Exception e) {
			System.out.println("파일유틸컬렉션 세이브텍스트 예외 "+ e.getMessage());
		}
	}
	
	public static String readText(String filename, String path) {  // 텍스트 읽어오는 메소드(스트링 파일명과 경로를 매개변수로 받음)
		StringBuilder sb = new StringBuilder(15000);
		try {
			File file = new File(path+filename);
			FileReader fileReader = new FileReader(file);
			BufferedReader bufferedReader = new BufferedReader(fileReader);
			String line = "";
			while((line= bufferedReader.readLine()) != null) {
				sb.append(line);
			}
			System.out.println("끝낫다" + new Date());
			bufferedReader.close();
		}catch (Exception e) {
			System.out.println("파일유틸컬렉션 리드텍스트 예외 " +e.getMessage());
		}
		
		return sb.toString();
	}
	
	public static void createFolder(String pathFolder) {  // 폴더 생성 메소드 (스트링 경로+폴더명을 매개변수로 받음)
		try {
			 File folder = new File(pathFolder);
			 if(!folder.exists()) {
				 folder.mkdir();
			 }
		}catch (Exception e) {
			System.out.println("파일유틸컬렉션 크리에이트폴더 예외 " +e.getMessage());
		}
	}
	
	public static void deleteFolder(String pathFolder) {  // 폴더 삭제 메소드 (스트링 경로+폴더명을 매개변수로 받음)
		try {
			deleteFilesInFolder(pathFolder);
			File folder = new File(pathFolder);
			if(folder.isDirectory()) {
				folder.delete();
			}
			
		}catch (Exception e) {
			System.out.println("파일유틸컬렉션 딜리트폴더 예외 " +e.getMessage());
		}
	}
	
	public static void deleteFile(String path) {  // 특정파일 한개 삭제 메소드 (파일경로를 매개변수로 받음)
		try {
			File file = new File(path);
			file.delete();
		}catch (Exception e) {
			System.out.println("파일유틸컬렉션 딜리트파일 예외 " +e.getMessage());
		}
	}
	
	public static void deleteFilesInFolder(String path) {  // 특정폴더에 있는 파일 전부 삭제 메소드 (폴더경로를 매개변수로 받음)
		try {
			File folder = new File(path);
			File[] files = folder.listFiles();
			for(File f : files) {
				f.delete();
			}
		}catch (Exception e) {
			System.out.println("파일유틸컬렉션 딜리트파일즈인폴더 예외 " +e.getMessage());
		}

	}
}
