const body = document.getElementById('body');

const loginLink = document.querySelector('.login_link');
const loginForm = document.querySelector('.login');

const registerLink = document.querySelector('.register_link');
const registerForm = document.querySelector('.register');

const forgotPasswordLink = document.querySelector('.forgotPassword');
const resetToLoginLink = document.querySelector('.resetToLogin_link');
const resetForm = document.querySelector('.reset');

reloadShowPw('login');
registerLink.addEventListener('click', () => {
	reloadShowPw('register');
    loginForm.style.display = 'none';
    body.style.height = '500px';
    body.style.width = '800px';
    registerForm.style.animation = 'formLoginToRegister ease 0.5s forwards';
    registerForm.style.display = 'block';
});

loginLink.addEventListener('click', () => {
	reloadShowPw('login');
    loginForm.style.display = 'block';
    loginForm.style.animation = 'formRegisterToLogin ease 0.5s forwards';
    body.style.width = '400px';
    body.style.height = '450px';
    registerForm.style.display = 'none';
});

forgotPasswordLink.addEventListener('click', () => {
	reloadShowPw('reset');
    loginForm.style.display = 'none';
    resetForm.style.animation = 'formLoginToReset ease 0.5s forwards';
    body.style.width = '400px';
    body.style.height = '550px';
    resetForm.style.display = 'block';
});

resetToLoginLink.addEventListener('click', () => {
	reloadShowPw('login');
    loginForm.style.display = 'block';
    loginForm.style.animation = 'formResetToLogin ease 0.5s forwards';
    body.style.width = '400px';
    body.style.height = '450px';
    resetForm.style.display = 'none';
    
});

function reloadShowPw(form) {
    document.querySelectorAll(`.${form} .input_box`).forEach(box => {
        const pwShowIcon = box.querySelector('.pw_show');
        const pwHideIcon = box.querySelector('.pw_hide');
        const passwordInput = box.querySelector('.input_password');

        if (pwShowIcon && pwHideIcon && passwordInput) {
            pwShowIcon.style.display = 'block';
            pwHideIcon.style.display = 'none';
            passwordInput.type = 'password';

            pwShowIcon.addEventListener('click', () => {
                passwordInput.type = 'text'; 
                pwShowIcon.style.display = 'none';
                pwHideIcon.style.display = 'block';
            });

            pwHideIcon.addEventListener('click', () => {
                passwordInput.type = 'password';
                pwShowIcon.style.display = 'block';
                pwHideIcon.style.display = 'none';
            });
        }
    });
}
// let listUsers = [];

// const initAppLogin = () => {
//     fetch('users.json')
//     .then(response => response.json())
//     .then(data => {
//         listUsers = data;
//         console.log(listUsers)
//     })
//     // .catch(error => console.error('Error fetching users:', error));
// }
// initAppLogin();

// const loginBtn = document.querySelector('.loginBtn');
// const loginPhoneInput = document.querySelector('.login_phone');
// const loginPasswordInput = document.querySelector('.login_password');
// const userName = document.querySelector('.header_userName');
// // const isLogin = {isConfirmLogin : false};

// // import { isLogin } from "./isLogin.js";

// loginBtn.addEventListener('click', () => {
//     // event.preventDefault();  

//     let name;
//     const loginPhone = loginPhoneInput.value;
//     const password = loginPasswordInput.value;
//     let isUserFound =false;

//     listUsers.forEach(user => {
//         if (user.phone === loginPhone && user.password === password) {
//             // console.log('true');
//             isUserFound = true;
//             name = user.name;
//         }
//         // else console.log('false');
//     });

//     if (isUserFound) {
//         userName.textContent = name;
//         alert('Đăng nhập thành công!');
//         // isLogin.isConfirmLogin = true;
//         // alert(isLogin.isConfirmLogin);
//     } else {
//         alert('Số điện thoại hoặc mật khẩu không chính xác!');
//     }
// });

// const registerBtn = document.querySelector('.registerBtn');
// const registerNameInput = document.querySelector('.username');
// const registerPhoneInput = document.querySelector('.register_phone');
// const registerPasswordInput = document.querySelector('.register_password');
// const registerRepeatPasswordInput = document.querySelector('.register_repeatPassword');
// const registerAgreeCheckbox = document.querySelector('.register_agree');

// registerBtn.addEventListener('click', () => {
//     if (!registerAgreeCheckbox.checked) {
//         alert('Vui lòng đồng ý với các điều lệ và điều khoản trước khi đăng ký.');
//         return; 
//     }

//     let name;
//     const registerPhone = registerPhoneInput.value;
//     const registerPassword = registerPasswordInput.value;
//     const registerRepeatPassword = registerRepeatPasswordInput.value;
//     let isPhoneNumFound = false;
//     let isRepeatPassword = true;

//     listUsers.forEach(user => {
//         if(user.phone === registerPhone){
//             isPhoneNumFound = true;
//         }
//     })
//     if(registerPassword !== registerRepeatPassword){
//         isRepeatPassword = false;
//     }

//     if(isPhoneNumFound){
//         alert('Số điện thoại đã tồn tại!');
//     }
//     else if(!isRepeatPassword){
//         alert('Nhập lại mật khẩu không chính xác!')
//     }
//     else{
//         alert('Đăng ký thành công');
//         loginForm.style.display = 'block';
//         loginForm.style.animation = 'formRegisterToLogin ease 0.5s forwards';
//         body.style.height = '450px';
//         registerForm.style.display = 'none';
//         loginPhoneInput.value = registerPhone; //dung value de luu gia tri moi
//         loginPasswordInput.value = registerPassword;

//         registerNameInput.value = '';
//         registerPhoneInput.value = '';
//         registerPasswordInput.value = '';
//         registerRepeatPasswordInput.value = '';
//         registerAgreeCheckbox.checked = false;
//     }
// });

// const resetBtn = document.querySelector('.resetBtn');
// const resetPhoneInput = document.querySelector('.reset_phone');
// const resetConfirm = document.querySelector('.confirm');
// const resetPasswordInput = document.querySelector('.reset_password');
// const resetRepeatPasswordInput = document.querySelector('.reset_repeatPassword');
// let isConfirm = false;
// // export const isConfirm = false;
// resetConfirm.addEventListener('click', (event) => {
//     // event.preventDefault();
//     const resetPhone = resetPhoneInput.value;
//     let isPhoneNumFound = false;

//     listUsers.forEach(user => {
//         if(user.phone === resetPhone){
//             isPhoneNumFound = true;
//         }
//     })

//     if(isPhoneNumFound){
//         isConfirm = true;
//         alert('Số điện thoại đã xác thực!')
//     }
//     else{
//         alert('Số điện thoại chưa được đăng ký!');
//     }
// });

// resetBtn.addEventListener('click', () => {
//     if(isConfirm){
//         if(resetPasswordInput.value === '' || resetRepeatPasswordInput.value === ''){
//             alert('Hãy nhập đầy đủ mật khẩu!');
//         }
//         else{
//             let isRepeatPassword = (resetPasswordInput.value === resetRepeatPasswordInput.value);
//             if(!isRepeatPassword){
//                 alert('Nhập lại mật khẩu không chính xác!')
//             }
//             else{
//                 alert('Thay đổi mật khẩu thành công');
//                 loginForm.style.display = 'block';
//                 loginForm.style.animation = 'formResetToLogin ease 0.5s forwards';
//                 resetForm.style.display = 'none';
//                 loginPhoneInput.value = resetPhoneInput.value; //dung value de luu gia tri moi != textContent
//                 loginPasswordInput.value = resetPasswordInput.value;
//                 isConfirm = false;
//                 // console.log(resetPasswordInput.value);
//                 resetPhoneInput.value = '';
//                 resetPasswordInput.value = '';
//                 resetRepeatPasswordInput.value = '';
//             }
//         }
//     }
//     else{
//         alert('Chưa xác thực số điện thoại!');
//     }
// });