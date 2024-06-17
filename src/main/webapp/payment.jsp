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
        <link rel="stylesheet" href="css/discount.css">
        <link rel="stylesheet" href="css/payment.css">  
        <link rel="stylesheet" href="css/scroll_bar.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap">
        <title>Thanh toán</title>
    </head>
    <body>
        <div id="bill">
            <div class="bill_back">
                <a href="home">
                    <i class="fa-solid fa-arrow-left"></i>
                    Quay lại
                </a>
            </div>
            <div class="bill_label">Thanh toán đơn hàng</div>
        	<c:set var = "totalCost" value = "0"/>
            <div class="bill_body">
                <div class="bill_listProd">
                <c:set var = "totalPrice" value = "0"/>
                	<c:forEach items = "${requestScope.listItem}" var = "i">
                		<div class = "billProdItem">
	                		<div class="billProdItem_img">
		                        <img src="${i.image}" alt="">
		                    </div>
		                    <div class="billProdItem_info">
		                        <div class="billProdItem_name">${i.quantity}x ${i.title}</div>
		                    	
		                        <div class="billProdItem_itemPrice">
		                            Đơn giá: ${i.price} VND
		                        </div>
		                        <fmt:parseNumber var = "a" type = "number" value = "${i.price}"/>
								<fmt:parseNumber var = "b" type = "number" value = "${i.quantity}"/>
								<c:set var = "totalPrice" value = "${totalPrice + a*b}" />
		                        <div class="billProdItem_price">
		                            Thành tiền: 
		                            <div class="billProd_total">${a*b} VNĐ</div>
		                        </div>
		                    </div>
	                	</div>
                		
                	</c:forEach>
                    
                </div>
                <c:set var = "u" value = "${requestScope.users }"/>
                <div class="bill_info">
                    <div class="bill_customerInfo">
                        <div class="billCustomerInfo_name">
                            <div class="">Họ tên</div>
                            <input readonly type="text" name="" id="" class="customerName" value = "${u.fullname }">
                        </div>
                        <div class="billCustomerInfo_phone">
                            <div class="">Số điện thoại</div>
                            <input readonly type="text" name="" id="" class="customerPhone" value = "${u.phoneNumber }">
                        </div>
                        <div class="billCustomerInfo_address">
                            <div class="">Địa chỉ</div>
                            <input readonly type="text" name="" id="" class="customerAddress" value = "${u.address }">
                        </div>
                    </div>
                    <div class="bill_note">
                        <div class="billNote">
                            <div class="">Ghi chú</div>
                            <input type="text" name="" id="" class="noteInput">
                        </div>
                    </div>
                    <div class="bill_payMethod">
                        <div class="payMethod">
                            <div>Phương thức thanh toán:</div>
                            <select class = "optPayMethod">
                            	<option value = "COD">COD</option>
                            	<option value = "VNPAY">VNPAY</option>
                            </select> 
                        </div>
                        <div class="tempPrice">
                            <div>Tạm tính:</div>
                            <div class="optTempPrice">${totalPrice} VND</div>
                        </div>
                        <div class="carriage">
                            <div>Phí vận chuyển:</div>
                            <c:set var = "shipFee" value = "15000" />
                            <div class="optCarriage">${shipFee } VNĐ</div>
                        </div>
                        
                    </div>
                    <div class="bill_discountCode">
                        <div class="">Mã giảm giá</div>
                        <div class="discountCode_bar">
                            <input type="text" name="" id="" class="discountCodeInput">
                            <i class="fa-solid fa-qrcode show_Voucher"></i> 
                        </div>
                    </div>
                    <div class="bill_pay">
                        <div>Thành tiền</div>
                        <div class="billTotalPrice">${totalPrice + shipFee} VNĐ</div>
                        <c:set var = "totalCost" value = "${totalPrice + shipFee}"/>
                    </div>
                </div>
            </div>
            <div class="bill_footer">
                <a class="optEdit">Thay đổi thông tin người nhận</a>
                <button class="optSave">Lưu thay đổi</button>
                <button class="payBtn" totalcost = "${totalCost }">Đặt hàng</button>
                <%-- <button class="payBtn_vnPay" totalcost = "${totalCost }">Đặt hàng VNPay</button> --%>
            </div>
        </div>
        
        <div class="overlay_voucher" style = "display: none">
            <div class="voucher_container">
                <i class="fa-solid fa-xmark cancel_voucher"></i>
                <div class="voucher_label">Mã giảm giá</div>
                <div class="search_bar">
                    <input id ='search_input' type="text" class="search_text" placeholder="Tìm mã giảm giá..." onkeyup="filterProducts()">
                    <button class="search_icon">	
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </div>
                <div class="voucher_list">
                	<c:forEach items = "${requestScope.listPromo }" var = "promo">
                		<c:set var = "isDisabled" value = "${promo.minimumPay > totalPrice }"/>
                		<div class = "voucher_item ${isDisabled ? 'disabled' : ''}" id = "${promo.id}">
	                		<div class="voucher_icon">
			                    <i class="fa-solid fa-utensils"></i>
			                </div>
			                <div class="voucher_info">
			                    <div class="voucher_num" >Giảm <fmt:formatNumber type = "number" pattern = "###">${promo.percent / 1000}</fmt:formatNumber>k</div>
			                    <div class="voucher_detail">Đơn tối thiểu <fmt:formatNumber type = "number" pattern = "###">${promo.minimumPay/1000}</fmt:formatNumber>k</div>
			                </div>
			                <div class="voucher_opt">
			                	<c:choose>
			                		<c:when test="${!isDisabled }">
			                			<button class="voucher_get" discount = "${promo.percent}" idPromo = "${promo.id }" >Mua ngay</button>
			                		</c:when>
			                		<c:otherwise>
			                			<button class="voucher_get" discount = "${promo.percent}"  >Không đủ điều kiện</button>
			                		</c:otherwise>
			                	</c:choose>
			                    
			                    <fmt:parseDate value = "${promo.endDate }" pattern="yyyy-MM-dd HH:mm:ss" var = "myDate"></fmt:parseDate>
			                    <div class="voucher_date">HSD: <fmt:formatDate value="${myDate}" pattern="dd-MM-yyyy"/></div>
			                </div>
			            </div>
                	</c:forEach>
                </div>
            </div>
        </div>
        <div class="updateItem">
            <div class="updateAlert">
                <i class="fa-solid fa-circle-exclamation"></i>
                <div class="updateAlert_label">Bạn có muốn lưu thông tin giao hàng này lại ?</div>
                <div class="updateOpt">
                    <button class="updateOpt_no">Không</button>
                    <button class="updateOpt_yes">Có</button>
                </div>
            </div>
        </div>
        <!-- <script src="script.js" type="module"></script> -->
         <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/payment.js"></script>
      
    </body>
</html>