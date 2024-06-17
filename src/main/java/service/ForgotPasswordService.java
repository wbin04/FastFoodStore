package service;

import repository.ForgotPasswordRepository;

public class ForgotPasswordService {
	private ForgotPasswordRepository forgotPasswordRepository = new ForgotPasswordRepository();
	
	public void Edit_Pass(String pass, String mail) {
		forgotPasswordRepository.Edit_Pass(pass, mail);
	}
	
	
}
