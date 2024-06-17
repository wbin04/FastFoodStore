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
			<c:set var = "o" value = "${requestScope.order}"/>
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
							<div class="orderInfo_detail">
                                <div class="orderInfo_detailForm">
	                                <div class="back order_back">
									    <a href = "orderManage">
									        <i class="fa-solid fa-arrow-left"></i>
									        Quay lại
									    </a>
									</div>
                                    <div class="orderDetail_label">Chi tiết đơn hàng</div>
                                    <div class="orderDetail_header">
                                        <div class="orderCode">Mã đơn hàng: ${o.id }</div>
                                        <div class="orderStatus">${o.orderStatus}</div>
                                    </div>
                                    
                                    <div class="orderDetail_body">
                                        <div class="orderReceiver">
                                            <div class="orderCustomerInfo">
                                                <div class="orderCustomerInfo_name">
                                                    <div class="">Họ tên</div>
                                                    <input type="text" name="" id="" class="customerName" value = "${o.receiverName }">
                                                </div>
                                                <div class="orderCustomerInfo_phone">
                                                    <div class="">Số điện thoại</div>
                                                    <input type="text" name="" id="" class="customerPhone" value = "${o.phoneNumber }">
                                                </div>
                                                <div class="orderCustomerInfo_address">
                                                    <div class="">Địa chỉ</div>
                                                    <input type="text" name="" id="" class="customerAddress" value = "${o.shipAddress }">
                                                </div>
                                                <div class="orderCustomerInfo_address">
                                                    <div class="">Ghi chú</div>
                                                    <input type="text" name="" id="" class="customerNote" value = "${o.note }">
                                                </div>
                                            </div>
                                            <div class="orderProcess">
                                                <div class="orderTime">
                                                    <div>Thời gian đặt hàng: ${o.createdDate }</div>
                                                </div>
                                                <!-- <div class="payTime">
                                                    <div>Thời gian thanh toán:</div>
                                                </div>
                                                <div class="deliveryTime">
                                                    <div>Thời gian vận chuyển:</div>
                                                </div>
                                                <div class="completeTime">
                                                    <div>Thời gian hoàn thành:</div>
                                                </div> -->
                                            </div>
                                            <div class="orderPayMethod">
                                                <div class="payMethod">
                                                    <div>Phương thức thanh toán:</div>
                                                    <div class="optPayMethod">${o.paymentMethod }</div>
                                                </div>
                                                <div class="carriage">
                                                    <div>Phí vận chuyển:</div>
                                                    <div class="optCarriage">15000 VNĐ</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="orderListProd">
											<div class="orderListProd_info">
												<c:set var="totalPrice" value="0" />
												<c:set var="ratedFoodIds"
													value="${requestScope.ratedProducts}" />
												<c:forEach items="${requestScope.listItem}" var="i">
													<div class="orderProdItem">
														<div class="orderProdItem_img">
															<img src="${i.image}" alt="">
														</div>
														<div class="orderProdItem_info">
															<div class="orderProdItem_name">${i.quantity}x
																${i.title}</div>
															<div class="orderProdItem_price">${i.price}VNĐ</div>
															<input type="checkbox" name="selectedProducts[]"
																value="${i.id}" class="selectedProduct"
																<c:if test="${ratedProducts.contains(i.id)}">disabled="disabled" checked="checked"</c:if>>
														</div>
													</div>
												</c:forEach>

                                        	</div>
                                        	<div class="orderDiscount">
                                                <div>Mã giảm giá</div>
                                                <div class="orderDiscountPrice">-${requestScope.discountAmount} VNĐ</div>
                                            </div>
                                        	<div class="orderPay">
                                                <div>Thành tiền</div>
                                                <div class="orderTotalPrice">${o.totalMoney} VNĐ</div>
                                            </div>
                                        </div>   
                                    </div>
                                    <div class="orderDetail_footer">
                                        <!-- <a class="optEdit">Thay đổi thông tin người nhận</a> -->
                                        <div class="optButton">
                                            <button class="optCancel" orderId = "${o.id}">Huỷ đơn hàng</button>
                                            <button class="optRate" id="rateButton" <c:if test="${requestScope.itemSize == requestScope.itemRate}"> style="display: none;"</c:if> >Đánh
											giá</button>
                                            <!-- <button class="optBuyBack">Mua lại</button> -->
                                        </div>
                                    </div>
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
									<input name="note" type="text" class="noteReason" required> 
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
                
                <form id="ratingForm" action="ratingf" method="post">
                	<input type="hidden" name="orderId" value="${o.id}">
					<div class="addRating" style="display: none;">
						<div class="ratingContainer">
							<div class="rating_label">Đánh giá sản phẩm</div>
							<div class="rating_star">
								<input hidden type="radio" name="rating" id="rating1" value="1">
								<label for="rating1" class="fa-solid fa-star"></label> <input
									hidden type="radio" name="rating" id="rating2" value="2">
								<label for="rating2" class="fa-solid fa-star"></label> <input
									hidden type="radio" name="rating" id="rating3" value="3">
								<label for="rating3" class="fa-solid fa-star"></label> <input
									hidden type="radio" name="rating" id="rating4" value="4">
								<label for="rating4" class="fa-solid fa-star"></label> <input
									hidden type="radio" name="rating" id="rating5" value="5">
								<label for="rating5" class="fa-solid fa-star"></label>
							</div>
							<textarea rows="5" class="ratingInput"
								placeholder="Nhập đánh giá của bạn ..." name="content"></textarea>
							<div class="confirmOpt">
								<button class="confirmOpt_yes" orderId = "${o.id}">Xác nhận</button>
								<button class="confirmOpt_no">Quay lại</button>
							</div>
						</div>
					</div>
			
				</form>
            </div>
            <div class="addRatingSuccess" style="display: none;">
				<div class="confirmAlert">
					<i class="fa-solid fa-circle-check"></i>
					<div class="confirmAlert_label">Thêm đánh giá thành công</div>
					<div class="confirmOpt">
						<button class="confirmOpt_ok">OK</button>
					</div>
				</div>
			</div>
        </div>
       <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/orderDetail.js"></script>
        <!-- <script src="script1.js"></script> -->
        <script>
/* 	        document
					.getElementById('rateButton')
					.addEventListener(
							'click',
							function() {
								var selectedProducts = document.querySelectorAll('.selectedProduct:checked');
								var form = document.getElementById('ratingForm');
								var oldInputs = form.querySelectorAll('input[name="selectedProducts[]"]');
								oldInputs.forEach(function(input) {
									input.remove();
								});
								selectedProducts.forEach(function(checkbox) {
									var input = document.createElement('input');
									input.type = 'hidden';
									input.name = 'selectedProducts[]';
									input.value = checkbox.value;
									form.appendChild(input);
								});
								document.querySelector('.addRating').style.display = 'flex';
							});
	        
			document
					.querySelector('.confirmOpt_no')
					.addEventListener(
							'click',
							function() {
								document.querySelector('.addRating').style.display = 'none';
							}); */
			$(document).ready(function() {
			    var itemSize = ${requestScope.itemSize};
			    var itemRate = ${requestScope.itemRate};
			    if(orderStatus.textContent === 'Đã hoàn thành'){
		    	    if(itemSize == itemRate) {
				        $('#rateButton').hide();
				    } else {
				        $('#rateButton').show();
				    }
			    }
			    
			    document.getElementById("scrollTo").addEventListener("click", function(event) {
		            sessionStorage.setItem("scrollToFooter", "true");
		        });
			});
			
        </script>
    </body>
</html>