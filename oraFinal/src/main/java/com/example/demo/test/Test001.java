package com.example.demo.test;

public class Test001 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		long num = System.currentTimeMillis();
		String str = String.valueOf(num);
		
		String re = str.substring(str.length() - 6);
		System.out.println(str);
		System.out.println(re);
	}

}
