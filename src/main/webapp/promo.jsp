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
        <link rel="stylesheet" href="css/cart.css">
        <link rel="stylesheet" href="css/discount.css">
        <link rel="stylesheet" href="css/scroll_bar.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap">
        <title>Trang chủ</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/autosize.js/4.0.2/autosize.min.js"></script>

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
                        <a href="#footer" id = "scrollTo">Liên hệ</a>
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
                    <div class="hdact act_item" onclick="showCart();">
                        <div  class="hdicon icon_cart">
                            <img src="assets/cart-shopping-solid.svg" alt="" class="hdcart_icon">
                            <span class="hdcart_numcount">${requestScope.cartSize }</span>
                        </div>
                    </div>
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
                    <div class="voucher_list">
                        <div class="voucherItem_label">Mã giảm giá</div>
                        <div class="voucherList_type voucherList_now">
							<c:forEach items = "${requestScope.listAvailablePromo }" var = "promo">
								<div class = "voucher_item">
									<div class="voucher_icon">
					                    <i class="fa-solid fa-utensils"></i>
					                </div>
					                <div class="voucher_info">
					                    <div class="voucher_num">Giảm <fmt:formatNumber type = "number" pattern = "###">${promo.percent / 1000}</fmt:formatNumber>k</div>
					                    <div class="voucher_detail">Đơn tối thiểu <fmt:formatNumber type = "number" pattern = "###">${promo.minimumPay/1000}</fmt:formatNumber>k</div>
					                </div>
					                <div class="voucher_opt">
					                    <button class="voucher_get" id = "${promo.id}">Mua ngay</button>
					                    <fmt:parseDate value = "${promo.endDate }" pattern="yyyy-MM-dd HH:mm:ss" var = "myDate"></fmt:parseDate>
			                    		<div class="voucher_date">Đến: <fmt:formatDate value="${myDate}" pattern="dd-MM-yyyy"/></div>
					                </div>
								</div>
							</c:forEach>
							
                        </div>
                        <div class="voucherItem_label status_soon">Sắp tới</div>
                        <div class="voucherList_type voucherList_soon">
							<c:forEach items = "${requestScope.listSoonPromo }" var = "sPromo">
								<div class = "voucher_item">
									<div class="voucher_icon">
					                    <i class="fa-solid fa-clock-rotate-left"></i>
					                </div>
					                <div class="voucher_info">
					                    <div class="voucher_num">Giảm <fmt:formatNumber type = "number" pattern = "###">${sPromo.percent / 1000}</fmt:formatNumber>k</div>
					                    <div class="voucher_detail">Đơn tối thiểu <fmt:formatNumber type = "number" pattern = "###">${sPromo.minimumPay/1000}</fmt:formatNumber>k</div>
					                </div>
					                <div class="voucher_opt">
					                    <button class="voucher_get" id = "${sPromo.id}">Đang chờ</button>
					                    <fmt:parseDate value = "${sPromo.startDate }" pattern="yyyy-MM-dd HH:mm:ss" var = "myDate"></fmt:parseDate>
			                    		<div class="voucher_date">Từ: <fmt:formatDate value="${myDate}" pattern="dd-MM-yyyy"/></div>
					                </div>
								</div>
							</c:forEach>
                        </div>
                    </div>
                </div>
            </div>
                <!-- <div id="cart"></div> -->
                <!-- <div id="cart"> -->
            <div class="col body_cart">
                <div class="cart_item cart_label">Giỏ hàng</div>
                <div class="cart_item cart_list">
                    <div class="deleteItem">
                        <div class="deleteAlert">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            <div class="deleteAlert_label">Bạn muốn xoá sản phẩm này ?</div>
                            <div class="deleteOpt">
                                <button class="delOpt_no">Không</button>
                                <button class="delOpt_yes">Có</button>
                            </div>
                        </div>
                    </div>
                    <!-- <div class="emptyCart">
                        <p>Giỏ hàng của bạn đang trống</p>
                    </div> -->
                    <div class="listCart">
						<c:set var = "totalPrice" value = "0" />
						<c:set var = "totalQuantity" value = "0" />
						<c:forEach items = "${requestScope.listItem }" var  = "i">
							<div class="list_item">
							<div class="prodInCart product_img">
		                        <img src="${i.image}" alt="" style="height: 100px; width: auto;">
		                    </div>
		                    <div class="prodInCart product_detail">
		                        <div class="prodInCart_detail prodDetail_label">${i.title}</div>
		                        <div class="prodInCart_detail prodDetail_action">
		                            <div class="prodInCart_action prodAct_price">${i.price}</div>
		                            <div class="prodInCart_action prodAct_quantity">
		                                <button  class="quantityCart_item subCart_btn" idFood = ${i.id} deli = "minus"><</button>
		                                <div class="quantityCart_item numCart_count" quantity = ${i.quantity} price = ${i.price }>${i.quantity}</div>
		                                <button  class="quantityCart_item addCart_btn" idFood = ${i.id} deli = "plus">></button>
		                            </div>
		                        </div>
		                    </div>
		                    <div  class="prodInCart_detail product_bin btn-xoa" idFood = ${i.id}  price = ${i.price }>
		                        <i class="fa-solid fa-trash"></i>
		                    </div>
		                    
							<fmt:parseNumber var = "a" type = "number" value = "${i.price}"/>
							<fmt:parseNumber var = "b" type = "number" value = "${i.quantity}"/>
							<c:set var = "totalQuantity" value = "${totalQuantity + b}" />
							<c:set var = "totalPrice" value = "${totalPrice + a*b}" />
							</div>
						</c:forEach>	                   				
                      </div>
                </div>
                <div class="cart_item cart_totalprice">
                    <div class="total_item total_label">Tạm tính:</div>
                    <div class="total_item total_price" >${totalPrice} VND</div>
                </div>
                <div class="cart_item cart_option">
                    <div class="cart_opt cart_close">Đóng</div>
                    <div class="cart_opt cart_pay"><a href = "#" onclick = "showCartEmpty()">Thanh toán</a></div>
                </div>
            </div>
                <!-- </div> -->

         	<footer id="footer">
                <div class="footer_item">
                    <div class="footerItem_label">
                        Hỗ trợ khách hàng
                    </div>
                    <div class="footerItem_opt">
                        <p>Hướng dẫn đặt hàng</p>
                        <p>Thanh toán và nhận hàng</p>
                    </div>
                </div>
                <div class="footer_item">
                    <div class="footerItem_label">
                        Liên hệ
                    </div>
                    <div class="footerItem_opt footerSet">
                        <p><i class="fa-solid fa-house"></i>54 Nguyễn Lương Bằng, Đà Nẵng</p>
                        <p><i class="fa-solid fa-phone"></i>0365096495</p>
                        <p><i class="fa-solid fa-envelope"></i>bachkhoa069@gmail.com</p>
                    </div>
                </div>
                <div class="footer_item">
                    <div class="footerItem_label">
                        Hệ thống cửa hàng
                    </div>
                    <div class="footerItem_opt footerSet">
                        <p><i class="fa-solid fa-house"></i>54 Nguyễn Lương Bằng, Đà Nẵng</p>
                        <p><i class="fa-solid fa-house"></i>34 Nam Cao, Đà Nẵng</p>
                    </div>
                </div>
                <div class="footer_item">
                    <div class="footerItem_label">
                        Thông tin khuyến mãi
                    </div>
                    <div class="footerItem_opt">
                        <input type="email" class="input_mail" placeholder="Nhập email của bạn...">
                        <button class="input_mailBtn">Đăng ký</button>
                    </div>
                </div>
            </footer>       
        </div>
        <!-- <script src="login_script.js"></script> -->
        <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/autosize.js/4.0.2/autosize.min.js"></script> -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/script1.js"></script>
        <script src="js/discount.js"></script>
    </body>
</html>