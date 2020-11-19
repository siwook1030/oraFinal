package com.example.demo.test;

class Person {
	int age;
	
}

public class Test05 {
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Person p = new Person();
		String str = "ababab";
		str = str.replace("ab", "cd");
		System.out.println("문자열:"+str);
	}

}
