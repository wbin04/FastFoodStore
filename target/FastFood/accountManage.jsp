<%@ page isELIgnored = "false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/base.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/account.css">
        <link rel="stylesheet" href="css/scroll_bar.css">
        <!-- <link rel="stylesheet" href="cart.css"> -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap">
        <title>Tài khoản</title>
    </head>
    <body>
        <div id="wrapper">
            <header id="header">
                <!-- <div class="header_overlay"></div> -->
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
                        <a href="home" id = "scrollTo">Liên hệ</a>
                    </div>
                    <c:choose>
                    	<c:when test="${empty sessionScope.roleAdmin}">
                    		 <div class="hdmenu menu_item" style = "display: none;" >
                    			<a href="adminManageUser">ADMIN</a>
                   			 </div>
                    	</c:when>
                        <c:otherwise>
                        	<div class="hdmenu menu_item" >
                    			<a href="adminManageUser">ADMIN</a>
                   			 </div>
                        </c:otherwise>
                   	</c:choose> 
                </div>
                <div class="header hd_actions">
                    <!-- <div class="hdact act_item" onclick="showCart();">
                        <div  class="hdicon icon_cart">
                            <img src="assets/cart-shopping-solid.svg" alt="" class="hdcart_icon">
                            <span class="hdcart_numcount">0</span>
                        </div>
                    </div> -->
                    <div class="hdact act_item">
                        <div class="hdicon icon_user">
                            <i class="fa-regular fa-circle-user"></i>
                             <div class="hdaccount">
                                <div class="hdaccount_manager">
                                    <a href="accountManage">Quản lý tài khoản</a>
                                </div>
                                <div class="hdaccount_manager">
                                    <a href="orderManage">Quản lý đơn hàng</a>
                                </div>
                                <div class="hdlogout">
                                    <a href="logout">Đăng xuất</a>
                                </div>
                            </div> 
                        </div>
                        
                    </div>
                    <div class="hdact act_item">
                    	<c:choose>
	                    	<c:when test="${empty sessionScope.account}">
	                    		<button class="header_login">
	                            	<a href="login" style="text-decoration: none; color: #000;">Đăng nhập</a>
	                        	</button>
	                    	</c:when>
	                        <c:otherwise>
	                        	<button class = "header_login">
	                        		<a href="" style="text-decoration: none; color: #000;">${sessionScope.account }</a>
	                        	</button>
	                        </c:otherwise>
                    	</c:choose>
                    </div>
                </div>
            </header>

            <div id="body">
                <div class="col body_page">
                    <div class="account_page">
                        <div class="account_opt">
                            <div class="account_manager">
                                <div class="optAccount_info">
                                    <i class="fa-solid fa-caret-right"></i>
                                    <a href = "accountManage">Thông tin tài khoản</a>
                                </div>
                                <div class="optOrder_info">
                                    <i class="fa-solid fa-caret-right iconRight"></i>
                                    <i class="fa-solid fa-caret-down iconDown"></i>
                                    <a href = "orderManage">Đơn hàng của tôi</a>
                                </div>
                                
                            </div>
                            <div class="account_logout">
                                <div class="optAccount_logout">
                                    <!-- <i class="fa-solid fa-arrow-right-from-bracket"></i>
                                    Đăng xuất -->
                                </div>
                            </div>
                        </div>
                        <c:set var = "u" value = "${requestScope.users}" />
                        <div class="account_info">
                            <div class="accountInfo_detail">
                                <div class="accInfo_form">
                                    <div class="accInfo_set accLabel">Thông tin tài khoản</div>
                                    <div class="accInfo_set accName">
                                        <div class="accName_label">Họ tên</div>
                                        <input type="text" name=""  class="setName" value = "${u.fullname }">
                                    </div>
                                    <div class="accInfo_set accNameUser">
                                        <div class="accNameUser_label">Tên tài khoản</div>
                                        <input type="text" name=""  class="setNameUser" value = "${u.username }" disabled>
                                    </div>
                                    <div class="accInfo_set accPhone">
                                        <div class="accPhone_label">Số điện thoại</div>
                                        <input type="text" name=""  class="setPhone" value = "${u.phoneNumber }">
                                    </div>
                                    <div class="accInfo_set accEmail">
                                        <div class="accEmail_label">Email</div>
                                        <input type="text" name=""  class="setEmail"  value = "${u.email }" disabled>
                                    </div>
                                    <!-- <div class="accInfo_set accGender">
                                        <div class="accGender_label">Giới tính</div>
                                        <select id="gender" name="gender" class="setGender">
                                            <option value="male">Nam</option>
                                            <option value="female">Nữ</option>
                                        </select>
                                    </div> -->
                                    <!-- <div class="accInfo_set accBirthday">
                                        <div class="accBirthday_label">Ngày sinh</div>
                                        <input type="text" name="" id="" class="setBirthday">
                                    </div> -->
                                    <div class="accInfo_set accAddress">
                                        <div class="accAddress_label">Địa chỉ</div>
                                        <input type="text" name=""  class="setAddress" value = "${u.address }">
                                    </div>
                                    <div class="accInfo_set updateInfo">
                                        <a class="changePassword">Đổi mật khẩu</a>
                                        <button class="saveInfo">Lưu thay đổi</button>
                                    </div>
                                </div>
                            </div>
                           
                        </div>
                    </div>
                </div>    
                <div class="confirmChangePassword">
                    <div class="confirmAlert">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <div class="confirmAlert_label">Thay đổi mật khẩu</div>
                        <div class="input_box">
							<span class="icon"> 
								<i class="fa-solid fa-lock"></i>
							</span> 
							<input name="pass" type="password" class="oldPassword" required> 
							<label>Mật khẩu cũ</label>
						</div>
                        <div class="input_box">
							<span class="icon"> 
								<i class="fa-solid fa-lock"></i>
							</span> 
							<input name="newpass" type="password" class="newPassword" required> 
							<label>Mật khẩu mới</label>
						</div>
						<div class="input_box">
							<span class="icon"> 
								<i class="fa-solid fa-lock"></i>
							</span> 
							<input name="passagain" type="password" class="newPasswordAgain" required> 
							<label>Nhập lại mật khẩu</label>
						</div>
                        <!-- <a class="forgotPassword">Quên mật khẩu ?</a> -->
                        <div class="confirmOpt">
                            <button class="confirmOpt_no">Quay lại</button>
                            <button class="confirmOpt_yes">Xác nhận</button>
                        </div>
                    </div>
                </div>
                <div class="confirmResetPassword">
                    <div class="confirmAlert">
                        <a class="backReset"> < Quay lại</a>
                        <!-- <i class="fa-solid fa-circle-exclamation"></i> -->
                        <div class="confirmAlert_label reset">Xác nhận</div>
                        <form action="#">
                            <div class="input_box">
                                <span class="icon"> 
                                    <i class="fa-solid fa-envelope"></i>
                                </span> 
                                <input name="mail" type="text" class="reset_email" required>
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
                                <span class="icon"> 
                                    <i class="fa-solid fa-code"></i>
                                </span> 
                                <input name="code" type="text" required> 
                                <label>Nhập mã xác thực</label>
                            </div>
                            <div class="input_box">
                                <span class="icon"> 
                                    <i class="fa-solid fa-lock"></i>
                                </span> 
                                <input name="pass" type="password" class="reset_password" required> 
                                <label>Mật khẩu mới</label>
                            </div>
                            <div class="input_box">
                                <span class="icon"> 
                                    <i class="fa-solid fa-lock"></i>
                                </span> 
                                <input name="passagain" type="password" class="reset_repeatPassword" required> 
                                <label>Nhập lại mật khẩu</label>
                            </div>
                            <button type="submit" class="resetBtn">Thay đổi mật khẩu</button>
                        </form>
                    </div>
                </div>
                <div class="confirmSuccess">
                    <div class="confirmAlert">
                        <i class="fa-solid fa-circle-check"></i>
                        <div class="confirmAlert_label">Thay đổi mật khẩu thành công</div>
                        <div class="confirmOpt">
                            <button class="confirmOpt_ok">OK</button>
                        </div>
                    </div>
                </div>
                <div class="confirmWrongPass">
                    <div class="confirmAlert">
                        <i class="fa-solid fa-times-circle"></i>
                        <div class="confirmAlert_label">Mật khẩu cũ không đúng</div>
                        <div class="confirmOpt">
                            <button class="confirmOptWP_ok">OK</button>
                        </div>
                    </div>
                </div>
                <div class="confirmCancel">
                    <div class="confirmAlert">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <div class="confirmAlert_label">Bạn muốn huỷ đơn hàng này ?</div>
                        <div class="input_box">
							<span class="icon"> 
								<i class="fa-solid fa-lock"></i>
							</span> 
							<input name="note" type="text" class="" required> 
							<label>Lý do huỷ đơn</label>
						</div>
                        <div class="confirmOpt">
                            <button class="confirmOpt_noCancel">Quay lại</button>
                            <button class="confirmOpt_yesCancel">Xác nhận</button>
                        </div>
                    </div>
                </div>
                <div class="confirmCancelSuccess">
                    <div class="confirmAlert">
                        <i class="fa-solid fa-circle-check"></i>
                        <div class="confirmAlert_label">Huỷ đơn hàng thành công</div>
                        <div class="confirmOpt">
                            <button class="confirmOpt_okCancel">OK</button>
                        </div>
                    </div>
                </div>        
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/account.js"></script>
      <!-- <script src="script1.js"></script> -->
    </body>
</html>