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
        <!-- <link rel="stylesheet" href="cart.css"> -->
        <link rel="stylesheet" href="css/scroll_bar.css">
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
                                <div class="optOrder_type">
                                    <div class="optOrder_wait">
                                        <i class="fa-solid fa-caret-right"></i>
                                        <a href = "orderManage?type=1">Chờ xác nhận</a>
                                    </div>
                                    <div class="optOrder_deliver">
                                        <i class="fa-solid fa-caret-right"></i>
                                         <a href = "orderManage?type=2">Đang vận chuyển</a>
                                        
                                    </div>
                                    <div class="optOrder_done">
                                        <i class="fa-solid fa-caret-right"></i>
                                        <a href = "orderManage?type=3">Đã hoàn thành</a>
                                    </div>
                                    <div class="optOrder_cancel">
                                        <i class="fa-solid fa-caret-right"></i>
                                        <a href = "orderManage?type=4">Đã huỷ</a>
                                    </div>
                                </div>
                            </div>
                            <div class="account_logout">
                                <div class="optAccount_logout">
                                    <!-- <i class="fa-solid fa-arrow-right-from-bracket"></i>
                                    Đăng xuất -->
                                </div>
                            </div>
                        </div>
                        <div class="account_info">
                         
                            <c:set var = "selectedOrderCode" value = ""/>
                            <div class="orderInfo_detail">
                                <div class="orderInfo_form">
                                    <div class="orderLabel">Danh sách đơn hàng</div>
                                    <div class="orderList">
                                    	<c:forEach items = "${requestScope.listOrder }" var = "o">
                                    		<div class="orderItem">
	                                            <div class="orderHeader">
	                                                <div class="orderCode">Mã đơn hàng: ${o.id }</div>
	                                                <div class="orderStatus">${o.orderStatus }</div>
	                                            </div>
	                                            <div class="orderBody">
	                                                <div class="orderProd_list">
	                                                	<jsp:useBean id = "listItem" class = "repository.OrdersRepository"/>
	                                                	<c:forEach items = "${listItem.getItemLine(o.id)}" var = "i">
		                                                	<div class="orderProd_item">                                  
		                                                        	<div class="itemContain_img">
		                                                            	<img src="${i.image }" alt="">
		                                                        	</div>
		                                                        	<div class="itemContain_info">
		                                                            	${i.quantity}x ${i.title }
		                                                        	</div>                                                       
		                                                    </div>
	                                                	</c:forEach>
	                                                </div>
	                                                <div class="orderProd_option">
	                                                    <div class="orderProd_price">
	                                                        <div class="overview_priceLabel">Thành tiền</div>
	                                                        <div class="overview_totalPrice">${o.totalMoney} VND</div>
	                                                    </div>
	                                                    <div class="containProd_opt">
	                                                        <button class="optDetail"><a href = "orderDetail?id=${o.id}">Chi tiết</a></button>
	                                                        <!-- <button class="optRate">Đánh giá</button> -->
	                                                        <!-- <button class="optBuyBack">Mua lại</button> -->
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
                                    	</c:forEach>
                                    </div>
                                </div>                 
                              
                            </div>
                        </div>
                    </div>
                </div>

                
            </div>
        </div>
       <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
	        const orderStatusElement = document.querySelectorAll('.orderStatus')
	
	        orderStatusElement.forEach(orderStatus => {
	        	switch(orderStatus.textContent){
	        	    case 'Chờ xác nhận':
	        	        orderStatus.style.color = '#FFD500'
	        	        break;
	        	    case 'Đang vận chuyển':
	        	        orderStatus.style.color = '#FF971C'
	        	        break;
	        	    case 'Đã hoàn thành':
	        	        orderStatus.style.color = '#72CB3B'
	        	        break;
	        	    case 'Đã huỷ':
	        	        orderStatus.style.color = '#FF3213'
	        	        break;
	        	    default: break;
	        	}
	        })
	        
	        document.getElementById("scrollTo").addEventListener("click", function(event) {
	            sessionStorage.setItem("scrollToFooter", "true");
	        });
        </script>
        <!-- <script src="script1.js"></script> -->
    </body>
</html>