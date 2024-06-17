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
            <link rel="stylesheet" href="css/admin.css">
            <link rel="stylesheet" href="css/admin_user.css">
            <link rel="stylesheet" href="css/admin_product.css">
            <link rel="stylesheet" href="css/admin_order.css">
            <link rel="stylesheet" href="css/admin_counting.css">
            <link rel="stylesheet" href="css/admin_counting_calendar.css"> 
            <link rel="stylesheet" href="css/scroll_bar.css">
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap">
            <title>ADMIN</title>
    </head>
    <body>
        <div id="wrapper">
            <div class="col_opt">
                <div class="admin">
                   <a href = "home"> <i class="fa-solid fa-house-user"></i></a>
                    ADMIN
                </div>
                <div class="manager">
                    <div class="manager_user">
                        <i class="fa-solid fa-caret-right"></i>
                        <a href = "adminManageUser">Quản lý tài khoản</a>
                    </div>
                    <div class="manager_product">
                        <i class="fa-solid fa-caret-right"></i>
                        <a href = "adminManageFood">Quản lý món ăn</a>
                    </div>
                    <div class="manager_order">
                        <i class="fa-solid fa-caret-right iconRight"></i>
                        <i class="fa-solid fa-caret-down iconDown"></i>
                        <a href = "adminManageOrders">Quản lý đơn hàng</a>         
                    </div>
                    <div class="manager_orderType">
                        <div class="adOrder_confirm">
                            <i class="fa-solid fa-caret-right"></i>
                            Chờ xác nhận
                        </div>
                        <div class="adOrder_deliver">
                            <i class="fa-solid fa-caret-right"></i>
                            Đang vận chuyển
                        </div>
                        <div class="adOrder_success">
                            <i class="fa-solid fa-caret-right"></i>
                            Đã hoàn thành
                        </div>
                        <div class="adOrder_cancel">
                            <i class="fa-solid fa-caret-right"></i>
                            Đã huỷ
                        </div>
                    </div>
                    <div class="manager_discount">
                        <i class="fa-solid fa-caret-right"></i>
                        <a href = "adminManagePromo">Quản lý khuyến mãi</a>
                    </div>
                    <!-- <div class="manager_rating">
                        <i class="fa-solid fa-caret-right"></i>
                        Quản lý đánh giá
                    </div> -->
                    <div class="manager_count">
                        <i class="fa-solid fa-caret-right"></i>
                        <a href = "adminManageStatistic">Thống kê doanh thu</a>
                    </div>
                </div>
                <div class="logout">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i>
                    <a href="logout">Đăng xuất</a>
                </div>
            </div>
            <c:set var = "t" value ="${requestScope.type }"/>
            <div class="col_info">
                <div class="managerOrderDetail_form">
                    <div class="back order_back">
                        <c:choose>
                        	<c:when test = "${type == 0}"  >
                        		<a href = "adminManageOrders">
		                            <i class="fa-solid fa-arrow-left"></i>
		                            Quay lại
		                        </a>
                        	</c:when>
                        	<c:otherwise>
                        		<a href = "adminManageOrders?type=${t }">
		                            <i class="fa-solid fa-arrow-left"></i>
		                            Quay lại
		                        </a>
                        	</c:otherwise>
                        </c:choose>
                    </div>
                     <c:set var = "o" value = "${requestScope.order}"/>
                    <div class="orderDetail_label">Chi tiết đơn hàng</div>
                    <div class="orderDetail_header">
                        <div class="orderCode">Mã đơn hàng: ${o.id }</div>
                        <div class="orderStatus">${o.orderStatus }</div>
                    </div>
                    <c:set var = "u" value = "${requestScope.user}"/>
                    <div class="orderDetail_body">
                        <div class="orderReceiver">
                            <div class="orderCustomerInfo">
                                <div class="orderCustomerInfo_name">
                                    <div class="">Họ tên</div>
                                    <input readonly type="text" name="" id="" class="customerName" value = "${u.fullname }">
                                </div>
                                <div class="orderCustomerInfo_phone">
                                    <div class="">Số điện thoại</div>
                                    <input readonly type="text" name="" id="" class="customerPhone" value = "${u.phoneNumber }">
                                </div>
                                <div class="orderCustomerInfo_address">
                                    <div class="">Địa chỉ</div>
                                    <input readonly type="text" name="" id="" class="customerAddress" value = "${u.address }">
                                </div>
                                <div class="orderCustomerInfo_address">
                                    <div class="">Ghi chú</div>
                                    <input readonly type="text" name="" id="" class="customerNote" value = "${o.note }">
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
                                <c:forEach items = "${requestScope.listItem }" var = "i">
	                                <div class="orderProdItem">
	                                    <div class="orderProdItem_img">
	                                        <img src="${i.image}" alt="">
	                                    </div>
	                                    <div class="orderProdItem_info">
	                                        <div class="orderProdItem_name">${i.quantity }x ${i.title }</div>
	                                        <div class="orderProdItem_price">${i.price } VNĐ</div>
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
                    <div class="orderBtnOption">
                        <!-- <a class="optEdit">Thay đổi thông tin sản phẩm</a>
                        <button class="optSave">Lưu thay đổi</button>
                        <button class="optDel">Xoá sản phẩm</button> -->
                        <button class="optCancel" orderId = "${o.id}">Huỷ đơn hàng</button>
                        <button class="optConfirm" orderId = "${o.id}">Xác nhận đơn hàng</button>
                        <button class ="optDone" orderId = "${o.id }">Hoàn thành</button>
                    </div>
                    <div class="confirmSuccess_order">
		                <div class="confirmAlert">
		                    <i class="fa-solid fa-circle-exclamation"></i>
		                    <div class="confirmAlert_label">Bạn muốn xác nhận đơn hàng này ?</div>
		                    <div class="confirmOpt">
		                        <button class="confirmOpt_no">Không</button>
		                        <button class="confirmOpt_yes">Có</button>
		                    </div>
		                </div>
		            </div>
		            <div class="confirmCancel_order">
		                <div class="confirmAlert">
		                    <i class="fa-solid fa-circle-exclamation"></i>
		                    <div class="confirmAlert_label">Bạn muốn huỷ đơn này ?</div>
		                    <div class="confirmOpt">
		                        <button class="confirmOpt_no">Không</button>
		                        <button class="confirmOpt_yes">Có</button>
		                    </div>
		                </div>
		            </div>
		            <div class="confirmCancel_order">
		                <div class="confirmAlert">
		                    <i class="fa-solid fa-circle-exclamation"></i>
		                    <div class="confirmAlert_label">Bạn muốn hoàn thành đơn hàng này ?</div>
		                    <div class="confirmOpt">
		                        <button class="confirmOpt_no">Không</button>
		                        <button class="confirmOpt_yes">Có</button>
		                    </div>
		                </div>
		            </div>
                </div>
            </div>
         </div>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>               
        <script src="js/adminManageOrders.js"></script>
    </body>
</html>        