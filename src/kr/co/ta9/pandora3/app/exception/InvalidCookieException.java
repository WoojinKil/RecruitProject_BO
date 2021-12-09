package kr.co.ta9.pandora3.app.exception;

public class InvalidCookieException extends RuntimeException {
	
	private static final long serialVersionUID = -5552773840594254205L;

	public InvalidCookieException(String message) {
		super(message);
	}
	
	public InvalidCookieException(String message, Throwable t) {
		super(message, t);
	}
}
