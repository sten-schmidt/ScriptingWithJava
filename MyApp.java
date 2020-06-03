package net.stenschmidt.shellscripts.java.MyApp; 

public class MyApp {
	public static void main (String[] args) {
		
		TestClass t = new TestClass();
		
		new HelloWorldWriter("Hello Test 987654321");
		
	}	
}

class HelloWorldWriter {
	public HelloWorldWriter(String text) {
		System.out.println(text);
	}
}

