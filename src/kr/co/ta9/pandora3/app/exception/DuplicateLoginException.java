package kr.co.ta9.pandora3.app.exception;

public class DuplicateLoginException extends RuntimeException {
	
	private static final long serialVersionUID = 8112318832143897579L;

	public DuplicateLoginException(String exMsg) {
		super(exMsg);
	}
	
	public DuplicateLoginException(String exMsg, Throwable throwable) {
		super(exMsg, throwable);
	}
}
