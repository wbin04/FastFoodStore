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
                    <div class="manager_orderType">
                        <div class="adOrder_confirm">
                            <i class="fa-solid fa-caret-right"></i>
                            Chờ xác nhận
                        </div>
                        <!-- <div class="adOrder_deliver">
                            <i class="fa-solid fa-caret-right"></i>
                            Đang vận chuyển
                        </div> -->
                        <div class="adOrder_success">
                            <i class="fa-solid fa-caret-right"></i>
                            Đã giao hàng
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
            <div class="col_info">
            	<div class="managerProduct_form">
                    <div class="header_form">
                        <div class="search_bar">
                            <input type="text" class="search_text" placeholder="Tìm món ăn...">
                            <button class="search_icon">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                        <div class="add_product">
                            <button class="add_productBtn">
                                <i class="fa-solid fa-plus"></i>
                                <a href = "adminAddFood">Thêm món ăn</a>
                            </button>
                        </div>
                    </div>
                    <div class="form_detail">
                        <div class="desc_form desc_product">
                            <div class="id_product">ID</div>
                            <div class="name_product">Tên món ăn</div>
                            <!-- <div class="phone_product">Mô tả</div> -->
                            <div class="price_product">Giá</div>
                            <div class="status_product">Trạng thái</div>
                            <div class="detail_product">Chi tiết</div>
                            <div class="delete_product">Xoá</div>
                        </div>
                        <div class="list_product">
                        	<c:forEach items = "${requestScope.listFood }" var = "f">
                        		<div class="productItem">
	                                <div class="id_product">${f.id}</div>
	                                <div class="name_product">${f.title }</div>
	                                <div class="price_product">${f.price}</div>
	                                <div class="status_product">
						                <select class = "status" name = "status" foodId = "${f.id }">
						                    <option value="Còn hàng" <c:if test = "${f.availability eq 'Còn hàng'}">selected</c:if>>Còn hàng</option>
						                    <option value="Tạm hết hàng"<c:if test = "${f.availability eq 'Tạm hết hàng'}">selected</c:if>>Tạm hết hàng</option>
						                </select>
						            </div>
	                                <div class="detail_product"><a href = "ManageFoodDetail?id=${f.id}"><i class="fa-solid fa-magnifying-glass detailProduct"></i></a></div>
	                                <div class="delete_product btn-xoa" idFood = ${f.id }><i class="fa-solid fa-trash deleteProduct"></i></div>
	                            </div>
                        	</c:forEach>
                           
                        </div>
                        <div class="footer_product">

                        </div>
                    </div>
                </div>
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
            </div>
        </div>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>               
        <script src="js/adminManageFood.js"></script>
    </body>
</html>        