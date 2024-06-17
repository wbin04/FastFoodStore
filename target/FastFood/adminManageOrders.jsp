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
            <link rel="stylesheet" href="css/admin_counting.css"">
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
                    <div class="manager_orderType" style="display: block;">
                        <div class="adOrder_confirm">
                            <i class="fa-solid fa-caret-right"></i>
                            <a href = "adminManageOrders?type=1">Chờ xác nhận</a>
                        </div>
                        <div class="adOrder_deliver">
                            <i class="fa-solid fa-caret-right"></i>
                            <a href = "adminManageOrders?type=2">Đang vận chuyển</a>
                        </div>
                        <div class="adOrder_success">
                            <i class="fa-solid fa-caret-right"></i>
                            <a href = "adminManageOrders?type=3">Đã hoàn thành</a>
                        </div>
                        <div class="adOrder_cancel">
                            <i class="fa-solid fa-caret-right"></i>
                            <a href = "adminManageOrders?type=4">Đã huỷ</a>
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
            <c:set var = "t" value = "${requestScope.type }"/>
            <div class="col_info">
            	<div class="managerOrder_form">
                    <div class="header_form">
                        <div class="search_bar">
                            <input id ='search_input' type="text" class="search_text" placeholder="Nhập mã đơn hàng..." onkeyup="filterProducts()">
                            <button class="search_icon">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </div>
                    <div class="form_detail">
                        <div class="desc_form desc_order">
                            <div class="id_order">ID</div>
                            <div class="name_order">Mã khách hàng</div>
                            <div class="address_order">Ngày tạo đơn</div>
                            <div class="price_order">Thành tiền</div>
                            <div class="status_order">Trạng thái</div>
                            <div class="detail_order">Chi tiết</div>
                        </div>
                        <div class="list_order">
                            <c:forEach items = "${requestScope.listOrder }" var = "o">
                            	<div class="orderItem" id = "${o.id }">
	                                <div class="id_order">${o.id }</div>
	                                <div class="name_order">${o.userId }</div>
	                                <div class="address_order">${o.createdDate }</div>
	                                <div class="price_order">${o.totalMoney }</div>
	                                <div class="status_order">${o.orderStatus }</div>
	                                <div class="detail_order">
		                                <a href = "ManageOrdersDetail?id=${o.id }&type=${t}">
		                                	<i class="fa-solid fa-magnifying-glass detailOrder"></i>
		                                </a>
	                                </div>
	                            </div>
                            </c:forEach>
                            
                        </div>
                        <div class="footer_order">

                        </div>
                    </div>
                </div>
            </div>
         </div>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>               
        <script>
	        const orderStatusElement = document.querySelectorAll('.status_order')
	
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
	        
	        function filterProducts() {
			   	var input = document.getElementById('search_input');
				var filter = input.value.toLowerCase();
				var orders = document.getElementsByClassName('orderItem');
				console.log(orders[0].getAttribute('id'))
				for (var i = 0; i < orders.length; i++) {
				    var id = orders[i].getAttribute('id').toLowerCase();
				    
				    if (id.indexOf(filter) > -1) {
				    	orders[i].style.display = '';
				    } else {
				    	orders[i].style.display = 'none';
				    }
				}
			}
        </script>
    </body>
</html>        