<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="css/base.css">
<link rel="stylesheet" href="css/dndk.css">
<link rel="stylesheet" href="css/scroll_bar.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap">
<title>Đăng nhập</title>
</head>
<body>
	<div id="wrapper">
		<header id="header">
			<div class="header_overlay"></div>
			<a href="home" class="header hd_logo"> 
				<img src="assets/Logo.jpg" alt="Home" class="image">
			</a>
			<div class="header hd_menu">
				<div class="hdmenu menu_item">
					<a href="home">Trang chủ</a>
				</div>
				<div class="hdmenu menu_item">
					<a href="menu">Sản phẩm</a>
				</div>
				<div class="hdmenu menu_item">
					<a href="promo">Khuyến mãi</a>
				</div>
				<div class="hdmenu menu_item">
					<a href="home#footer">Liên hệ</a>
				</div>
			</div>
			<div class="header hd_actions">
				<div class="hdact act_item" onclick="showCart();">
					<div class="hdicon icon_cart">
						<!-- <i class="fa-solid fa-bag-shopping"></i> -->
						<img src="assets/cart-shopping-solid.svg" alt=""
							class="hdcart_icon"> <span class="hdcart_numcount"></span>
					</div>
				</div>
				<div class="hdact act_item">
					<div class="hdicon icon_user">
						<i class="fa-regular fa-circle-user"></i>
					</div>
				</div>
				<div class="hdact act_item">
					<button class="header_login">
						<a href="home" class="header_userName"
							style="text-decoration: none; color: #000;">Đăng nhập</a>
					</button>
				</div>
			</div>
		</header>
		<div id="body">
			<form action="login" method="post">
				<div class="form-box login">
					<h2>Đăng nhập</h2>
					<h3 style="color: red">${requestScope.error}</h3>
					<%-- <h2 style="color: red"> <%=request.getAttribute("msgregister") !=null ? request.getAttribute("msgregister") : " " %> </h2> --%>
					<form action="#">
						<div class="input_box">
							<span class="icon"> <i class="fa-solid fa-user"></i>
							</span> <input name="user" type="text" value="${cookie.user.value}"
								class="login_username" required> <label>Tên đăng
								nhập</label>
						</div>
						<div class="input_box">
							<span class="icon"> 
								<i class="fa-solid fa-eye pw pw_show"></i>
								<i class="fa-solid fa-eye-slash pw pw_hide"></i>
							</span> <input name="pass" value="${cookie.pass.value}" type="password"
								class="input_password login_password" required> <label>Mật khẩu</label>
						</div>
					</form>
					<div class="remember-forgot">
						<label><input name="rem" type="checkbox"
							${(cookie.rem.value eq 'ON')?"checked":"" } value="ON">Ghi
							nhớ tài khoản</label> <a href="#" class="forgotPassword">Quên mật
							khẩu ?</a>
					</div>
					<button type="submit" class="loginBtn">Đăng nhập</button>
					<div class="login-register">
						<p>
							Bạn chưa có tài khoản ? <a href="#" class="register_link">Đăng
								ký ngay</a>
						</p>
					</div>
				</div>
			</form>
			<form action="signup" method="post" accept-charset="UTF-8">
				<div class="form-box register">
					<h2>Đăng ký</h2>
					<div class="form">
						<!-- <form action="#"></form> -->
						<form action="#">
							<div class="col">
								<div class="input_box">
									<span class="icon"> <i class="fa-solid fa-user"></i>
									</span> <input accept-charset="UTF-8" name="fullname" type="text" class="register_fullname"
										required> <label>Họ và tên</label>
								</div>
								<div class="input_box">
									<span class="icon"> <i class="fa-solid fa-user"></i>
									</span> <input name="user" type="text" class="register_username"
										 required> <label>Tên tài khoản</label>
								</div>
								<div class="input_box">
									<span class="icon"> 
										<i class="fa-solid fa-eye pw pw_show"></i>
										<i class="fa-solid fa-eye-slash pw pw_hide"></i>
									</span> <input name="pass" type="password" class="input_password register_password"
										required> <label>Mật khẩu</label>
								</div>
								<div class="input_box">
									<span class="icon"> 
										<i class="fa-solid fa-eye pw pw_show"></i>
										<i class="fa-solid fa-eye-slash pw pw_hide"></i>
									</span> <input type="password" class="input_password register_repeatPassword"
										required> <label>Nhập lại mật khẩu</label>
								</div>
							</div>
							<div class="col">
								<div class="input_box">
									<span class="icon"> <i class="fa-solid fa-phone-flip"></i>
									</span> <input name="phonenumber" type="text" class="register_phone"
										required> <label>Số điện thoại</label>
								</div>
								<div class="input_box">
									<span class="icon"> <i class="fa-solid fa-envelope"></i>
									</span> <input name="email" type=" text" class="register_email"
										 required> <label>Email</label>
								</div>
								<div class="input_box">
									<span class="icon"> <i
										class="fa-solid fa-map-location-dot"></i>
									</span> <input accept-charset="UTF-8" name="address" type="text" class="register_address"
										required> <label>Địa chỉ</label>
								</div>
								<div class="remember-forgot registerAgree">
									<label class="registerAgree"> <input type="checkbox"
										class="register_agree">Tôi đồng ý với các điều lệ và
										điều khoản
									</label>
								</div>
							</div>
						</form>
					</div>


					<button type="submit" class="registerBtn">Đăng ký</button>

					<div class="login-register">
						<p>
							Bạn đã có tài khoản ? 
							<a href="#" class="login_link">Đăng nhập ngay</a>
						</p>
					</div>
				</div>
			</form>
			<form action="#">
				<div class="form-box reset">
					<h2>Đặt lại mật khẩu</h2>
					<h3 style="color: red">${requestScope.error_code}</h3>
					<form action="#">
						<div class="input_box">
							<span class="icon"> <i class="fa-solid fa-envelope"></i>
							</span> <input name="mail" type="text" class="reset_email" required>
							<label>Email</label>
						</div>
						<form action="sendcode" method="post">
							<div class="remember-forgot">
								<!-- <label><input type="checkbox" class="confirm">Tôi đồng ý với các điều lệ và điều khoản</label> -->
								<a href="#" class="confirm" type="submit">Gửi mã xác thực</a>
								<!-- <button type="submit" class="resetBtn">Gửi mã xác thực</button> -->
							</div>
						</form>

						<div class="input_box">
							<span class="icon"> <i class="fa-solid fa-user"></i>
							</span> <input name="code" type="text" class = "OTPCode" required> 
							<label>Nhập mã xác thực</label>
						</div>
						<div class="input_box">
							<span class="icon"> 
								<i class="fa-solid fa-eye pw pw_show"></i>
								<i class="fa-solid fa-eye-slash pw pw_hide"></i>
							</span> <input name="pass" type="password" class="input_password reset_password"
								required> <label>Mật khẩu mới</label>
						</div>
						<div class="input_box">
							<span class="icon"> 
								<i class="fa-solid fa-eye pw pw_show"></i>
								<i class="fa-solid fa-eye-slash pw pw_hide"></i>
							</span> <input name="passagain" type="password"
								class="input_password reset_repeatPassword" required>
								 <label>Nhập lại mật khẩu</label>
						</div>
						<button type="submit" class="resetBtn">Thay đổi mật khẩu</button>

						<div class="login-register">
							<p>
								<a href="#" class="resetToLogin_link">Đăng nhập</a>
							</p>
						</div>
					</form>
				</div>
			</form>

		</div>
	</div>
	<script src="js/login_script.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script>
	var registerBtn = document.querySelector('.registerBtn')	
	$(document).ready(function() {
			var isClicked = false;
			$(".confirm").click(function(e) {
				e.preventDefault();
				/* var email = $(".reset_email").val();
				console.log(email) */
				isClicked = true;
				var email = $(".reset_email")[0];
		        if (!email.checkValidity()) {
		            email.reportValidity();
		            return;
		        }

				$.ajax({
					url : 'sendcode',
					type : 'post',
					data : {
						mail : email.value
					},
					success : function(response) {
						if(response.isSuccess)
							alert('Mã xác thực đã được gửi đến email của bạn');
						else alert(response.description);
					},
					error : function(error) {
						alert('Có lỗi xảy ra, vui lòng thử lại' + error);
					}
				});			
			});
			
			$(".resetBtn").click(function(e){
				e.preventDefault();
				/* var email = $(".reset_email").val();
				var code = $(".OTPCode").val();
				var resetPassword = $(".reset_password").val(); */
				if(!isClicked){
					alert ('Bạn chưa nhấn gửi mã xác thực');
					return;
				}
				var email = $(".reset_email")[0];
		        var code = $(".OTPCode")[0];
		        var resetPassword = $(".reset_password")[0];
		        var resetRepeatPassword = $(".reset_repeatPassword")[0];
		        
		        if (!email.checkValidity()) {
		            email.reportValidity();
		            return;
		        }
		        if (!code.checkValidity()) {
		            code.reportValidity();
		            return;
		        }
		        if (!resetPassword.checkValidity()) {
		            resetPassword.reportValidity();
		            return;
		        }
		        if (!resetRepeatPassword.checkValidity()) {
		            resetRepeatPassword.reportValidity();
		            return;
		        }
		        
		        if (resetPassword.value !== resetRepeatPassword.value) {
		            alert('Mật khẩu và mật khẩu nhập lại không khớp');
		            return;
		        }
		        
				$.ajax({
					url : 'resetPass',
					type : 'post',
					data : {
						mail : email.value, code: code.value, pass: resetPassword.value
					},
					success : function(response) {
						if(response.isSuccess){
							alert(response.description);
							window.location.href = "login";
						}
							
						else alert(response.description);
					},
					error : function(error) {
						alert('Có lỗi xảy ra, vui lòng thử lại' + error);
					}
				});		
			})
		});	
		document
			.querySelector('.register_repeatPassword')
			.addEventListener(
				'input',
				function() {
					var password = document
						.querySelector('.register_password').value;
					var repeatPassword = document
						.querySelector('.register_repeatPassword').value;
					var errorMessage = document
						.querySelector('.passwordError');
	
					if (password !== repeatPassword) {
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
		document.querySelector('.register_phone').addEventListener('input', function() {
			var phoneNumber = this.value;
			var errorMessage = document.querySelector('.phoneError');
	
			if (!/^((0)|84)[0-9]{9}$/.test(phoneNumber)) {
				if (!errorMessage) {
					errorMessage = document.createElement('p');
					errorMessage.style.color = 'red';
					errorMessage.classList.add('phoneError');
					this.parentNode.insertBefore(errorMessage, this.nextSibling);
				}
				errorMessage.innerHTML = 'Gồm 10 chữ số, bắt đầu 0 hoặc 84';
				registerBtn.disabled = true;
			} else {
				if (errorMessage) {
					errorMessage.remove();
				}
				registerBtn.disabled = false;
			}
		});
	
		document.querySelector('.register_email').addEventListener('input', function() {
			var email = this.value;
			var errorMessage = document.querySelector('.emailError');
	
			if (!/^[^@]+@[^@]+\.[^@]+$/.test(email)) {
				if (!errorMessage) {
					errorMessage = document.createElement('p');
					errorMessage.style.color = 'red';
					errorMessage.classList.add('emailError');
					this.parentNode.insertBefore(errorMessage, this.nextSibling);
				}
				errorMessage.innerHTML = 'Email có định dạng abc@def.xyz';
				registerBtn.disabled = true;
			} else {
				if (errorMessage) {
					errorMessage.remove();
				}
				registerBtn.disabled = false;
			}
		});
		
		document.querySelector('.reset_email').addEventListener('input', function() {
			var email = this.value;
			var errorMessage = document.querySelector('.emailError');
	
			if (!/^[^@]+@[^@]+\.[^@]+$/.test(email)) {
				if (!errorMessage) {
					errorMessage = document.createElement('p');
					errorMessage.style.color = 'red';
					errorMessage.classList.add('emailError');
					this.parentNode.insertBefore(errorMessage, this.nextSibling);
					document.querySelector('.confirm').style.color = '#f9e1cc';
					document.querySelector('.confirm').style.pointerEvents = 'none';
				}
				errorMessage.innerHTML = 'Email có định dạng abc@def.xyz';
		
			} else {
				if (errorMessage) {
					errorMessage.remove();
					document.querySelector('.confirm').style.color = '#000';
					document.querySelector('.confirm').style.pointerEvents = 'auto';
				}
			}
			// reload();
		});

		var inputElements = document.querySelectorAll('.input_box input');

			inputElements.forEach(function(input) {
				input.addEventListener('focus', function() {
					this.nextElementSibling.style.top = '-1px';
				});

				input.addEventListener('blur', function() {
					if (!this.value.trim()) {
						this.nextElementSibling.style.top = '';
					}
				});

				input.addEventListener('input', function() {
					if (this.validity.valid) {
						this.nextElementSibling.style.top = '-1px';
					} else {
						this.nextElementSibling.style.top = '';
					}
				});
			});
	
		$(document).ready(function() {
		    $('form[action="signup"]').submit(function(event) {
		        event.preventDefault(); 
		        
		        var userInput = document.querySelector('.register_username');
		        var emailInput = document.querySelector('.register_email');
		        
		        var username = userInput.value;
		        var email = emailInput.value;
		        
		        var request1 = $.ajax({
		            method: "POST",
		            url: "http://localhost:8080/FastFood/api/user/getUsername",
		            data: {username: username}
		        });

		        var request2 = $.ajax({
		            method: "POST",
		            url: "http://localhost:8080/FastFood/api/user/getEmail",
		            data: {email: email}
		        });

		        $.when(request1, request2).done(function(response1, response2) {
		            var un = response1[0];
		            var em = response2[0];
		            
		            if(!un.isSuccess) {
		                alert(un.description);
		            } else if (!em.isSuccess) {
		                alert(em.description);
		            } else {
		            	$.ajax({
		                    method: "POST",
		                    url: "http://localhost:8080/FastFood/signup",
		                    data: $('form[action="signup"]').serialize(), 
		                    success: function(response) {
		                        alert("Đăng ký thành công!");
		                        window.location.href = 'http://localhost:8080/FastFood/login'
		                    },
		                    error: function(xhr, status, error) {
		                        alert("Đã xảy ra lỗi: " + error);
		                        console.error(xhr, status, error);
		                    }
		                });
		            }
		        }).fail(function(xhr, status, error) {
		            alert("Đã xảy ra lỗi: " + error);
		            console.error(xhr, status, error);
		        });
		    });
		});
	</script>
	
</body>
</html>
