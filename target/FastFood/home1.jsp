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
        <link rel="stylesheet" href="css/scroll_bar.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap">
        <title>Trang chủ</title>
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
                        <div class="hdicon icon_user" <c:if test = "${empty sessionScope.account}">style = "pointer-events: none"</c:if>>
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
                    <div class="slider">
                        <div class="list">
                            <div class="slider_item">
                                <img src="assets/banner_chicken.png" alt="">
                            </div>
                            <div class="slider_item">
                                <img src="assets/banner_burger.png" alt="">
                            </div>
                            <div class="slider_item">
                                <img src="assets/banner_frech-fries.png" alt="">
                            </div>
                        </div>
                        <div class="buttons">
                            <button id="prev"><</button>
                            <button id="next">></button>
                        </div>
                        <ul class="dots">
                            <li class="active"></li>
                            <li></li>
                            <li></li>
                        </ul>
                    </div>
                    <div id="wp-products">
                        <div class="opt_products">
                            <ul>
                                <li style = "color: #ff7d01; font-size: 2em;">Sản phẩm bán chạy</li>
                            </ul>
                        </div>
                        <ul id="list-products">
                        	<c:forEach items = "${requestScope.listBestSellerFood }" var = "f">
                        		<div class = "product_item">
	                        		<label for="overlay_on" class="item" onclick="showPopUp('${f.id}', '${f.title}', '${f.description}', '${f.price}', '${f.image}', '${f.availability}')">
					                    <img src="${f.image}" alt="" style="height: 300px;">
					                    <div class="name">${f.title}</div>
					                    <div class="price">${f.price} VNĐ</div>
					                    <button class="addcart">Thêm vào giỏ hàng</button>
	               					 </label>
                        		</div>		                          
		                    </c:forEach>
                        </ul>
                        <input type="checkbox" hidden class="overlay_off" id="overlay_on">
                        <div id="popup"></div>
                        <div class="more_products">
                            <a href="menu">
                                <button class="more_products-btn">Xem thêm sản phẩm</button>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- <div id="cart"></div> -->
                <div id="cart">
                    <div class="col body_cart">
                        <div class="cart_item cart_label">Giỏ hàng</div>
                        <div class="cart_item cart_list">
                        	<div class="deleteItem">
                                <div class="deleteAlert">
                                    <i class="fa-solid fa-circle-exclamation"></i>
                                    <div class="deleteAlert_label">Bạn muốn xoá món ăn này ?</div>
                                    <div class="deleteOpt">
                                        <button class="delOpt_no">Không</button>
                                        <button class="delOpt_yes">Có</button>
                                    </div>
                                </div>
                            </div>
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
                </div>
            </div>
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
        <script src="js/slider_script.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/script1.js"></script>
        
    </body>
</html>

