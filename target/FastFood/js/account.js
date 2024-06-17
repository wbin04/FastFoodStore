$(document).ready(function(){
	$('.saveInfo').click(function(){
		var fullnameInput = document.querySelector('.setName');
		var phoneInput = document.querySelector('.setPhone');
		var addressInput = document.querySelector('.setAddress');
		
		var fullname = fullnameInput.value;
		var phoneNumber = phoneInput.value;
		var address = addressInput.value;
		$.ajax({
			method: "POST",
		    url: "http://localhost:8080/FastFood/api/user/update",
		    data: {fullname: fullname, phoneNumber: phoneNumber, address: address }
		  }).done(function(data) {
		        alert("Đã lưu thành công");
		  }).fail(function(xhr, status, error) {
		        alert("Đã xảy ra lỗi: " + error);
		        console.error(xhr, status, error);
		})
	})
	$('.confirmOpt_yes').click(function(){
		var oldPasswordInput = document.querySelector('.oldPassword');
		var newPasswordInput = document.querySelector('.newPassword');
		var newPasswordAgainInput = document.querySelector('.newPasswordAgain');
		
		var oldPassword = oldPasswordInput.value;
		var newPassword = newPasswordInput.value;
		var newPasswordAgain = newPasswordAgainInput.value;
		
		$.ajax({
			method: "POST",
			url: "http://localhost:8080/FastFood/api/user/changepass",
			data: {oldPassword: oldPassword, newPassword: newPassword, newPasswordAgain: newPasswordAgain}
		}).done(function(data) {
			confirmChangePassword.style.display = 'none';
			if(data.isSuccess){
				confirmSuccess.style.display = 'flex';
			}
			else if (!data.isSuccess && data.description === 'Sai mật khẩu'){
				confirmWrongPass.style.display = 'flex';
			}	
	  	}).fail(function(xhr, status, error) {
	        alert("Đã xảy ra lỗi: " + error);
	        console.error(xhr, status, error);
		})
	})
	document.getElementById("scrollTo").addEventListener("click", function(event) {
        sessionStorage.setItem("scrollToFooter", "true");
    });
})

document.querySelector('.newPasswordAgain').addEventListener('input',function() {
	var oldPasswordInput = document.querySelector('.oldPassword');
	var newPasswordInput = document.querySelector('.newPassword');
	var newPasswordAgainInput = document.querySelector('.newPasswordAgain');
	
	var oldPassword = oldPasswordInput.value;
	var newPassword = newPasswordInput.value;
	var newPasswordAgain = newPasswordAgainInput.value;
	
	var errorMessage = document
		.querySelector('.passwordError');

	if (newPassword !== newPasswordAgain) {
		if (!errorMessage) {
			errorMessage = document.createElement('p');
			errorMessage.style.color = 'red';
			errorMessage.classList.add('passwordError');
			this.parentNode.insertBefore(errorMessage,
				this.nextSibling);
		}
		errorMessage.innerHTML = 'Mật khẩu nhập lại không trùng khớp!';
	} else {
		if (errorMessage) {
			errorMessage.remove();
		}
	}
});



const confirmChangePassword = document.querySelector('.confirmChangePassword');
const confirmResetPassword = document.querySelector('.confirmResetPassword');

const changePassword = document.querySelector('.changePassword');
changePassword.addEventListener('click', () => {
    confirmChangePassword.style.display = 'flex';
});

// const forgotPassword = document.querySelector('.forgotPassword');
// forgotPassword.addEventListener('click', () => {
//     confirmResetPassword.style.display = 'flex';
// });

const confirmOpt_no = document.querySelector('.confirmOpt_no');
confirmOpt_no.addEventListener('click', () => {
    confirmChangePassword.style.display = 'none';
});

// const backReset = document.querySelector('.backReset');
// backReset.addEventListener('click', () => {
//     confirmResetPassword.style.display = 'none';
// });

const confirmSuccess = document.querySelector('.confirmSuccess');
const confirmWrongPass = document.querySelector('.confirmWrongPass');
const confirmOpt_ok = document.querySelector('.confirmOpt_ok');
const confirmOptWP_ok = document.querySelector('.confirmOptWP_ok');
const confirmOpt_yes = document.querySelector('.confirmOpt_yes');
// const resetBtn = document.querySelector('.resetBtn');


// resetBtn.addEventListener('click', () => {
//     confirmSuccess.style.display = 'flex';
//     confirmChangePassword.style.display = 'none';
//     confirmResetPassword.style.display = 'none';
// });

confirmOpt_ok.addEventListener('click', () => {
    confirmSuccess.style.display = 'none';
});

confirmOptWP_ok.addEventListener('click', () => {
    confirmWrongPass.style.display = 'none';
});



/*const optCancel = document.querySelector('.optCancel');
const confirmCancel = document.querySelector('.confirmCancel');
optCancel.addEventListener('click', () => {
    confirmCancel.style.display = 'flex';
});*/

/*const confirmOpt_noCancel = document.querySelector('.confirmOpt_noCancel');
confirmOpt_noCancel.addEventListener('click', () => {
    confirmCancel.style.display = 'none';
});

const confirmOpt_yesCancel = document.querySelector('.confirmOpt_yesCancel');
const confirmCancelSuccess = document.querySelector('.confirmCancelSuccess');
confirmOpt_yesCancel.addEventListener('click', () => {
    confirmCancelSuccess.style.display = 'flex';
    confirmCancel.style.display = 'none';
});

const confirmOpt_okCancel = document.querySelector('.confirmOpt_okCancel');
confirmOpt_okCancel.addEventListener('click', () => {
    confirmCancelSuccess.style.display = 'none';
});*/