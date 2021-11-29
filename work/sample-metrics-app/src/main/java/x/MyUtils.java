package x;

import java.util.Random;

public class MyUtils {
	
	private static final Random random = new Random();
	
	public static void randomDelay (int upto) {
		randomDelay(0,upto);
		
	}
	public static void randomDelay (int from, int upto) {
		try {
			int sleepInterval = from + random.nextInt(upto-from+1);
			Thread.sleep(sleepInterval);
		} catch (InterruptedException e) { }
		
	}

	public static void sleepFor (int time) {
		try {
			Thread.sleep(time);
		} catch (InterruptedException e) { }
		
	}
	

}
