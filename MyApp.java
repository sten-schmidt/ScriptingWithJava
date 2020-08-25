package net.stenschmidt.shellscripts.java.MyApp; 

public class MyApp {
	public static void main (String[] args) {
		
		TestClass t = new TestClass();
		
		new HelloWorldWriter("Hello Test 987654321");

		//Commandline-Arguments
		if (args != null && args.length >= 1) {
			System.out.println("Java-Commandline-Args: " + String.join(" ", args));
		}
	}	
}

class HelloWorldWriter {
	public HelloWorldWriter(String text) {
		System.out.println(text);
	}
}

