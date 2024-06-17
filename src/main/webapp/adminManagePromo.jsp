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
            <link rel="stylesheet" href="css/admin_discount.css"">
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
                <!--     <div class="manager_orderType" style="display: block;">
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
                    </div> -->
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
            	<div class="managerDiscount_form">
                    <div class="header_form">
                        <div class="add_voucher">
                            <button class="add_voucherBtn">
                                <i class="fa-solid fa-plus"></i>
                                <a href = "adminAddVoucher">Thêm mã giảm giá</a>
                            </button>
                        </div>
                        <!-- <div class="filter_voucher">
                            <div>Trạng thái:</div>
                            <select class="voucher_status" onchange="showVoucher(this)">
                                <option value="status_invalid">Hết hiệu lực</option>
                                <option value="status_valid" selected>Đang sử dụng</option>
                                <option value="status_soon">Sắp tới</option>
                            </select>
                        </div> -->
                    </div>
                    <div class="form_detail">
                        <div class="desc_form desc_voucher">
                            <div class="id_voucher">ID</div>
                            <div class="discount_voucher">Giảm</div>
                            <div class="startDate_voucher">Ngày bắt đầu</div>
                            <div class="endDate_voucher">Ngày kết thúc</div>
                            <div class="minOrder_voucher">Đơn tối thiểu</div>
                            <div class="update_voucher">Cập nhật</div>
                            <div class="delete_voucher">Xoá</div>
                        </div>
                        <div class="list_voucher">
                            <c:forEach items = "${requestScope.listPromo }" var = "promo">
                            	<div class="voucherItem">
	                                <div class="id_voucher">${promo.id }</div>
	                                <div class="discount_voucher">${promo.percent }</div>
	                                <fmt:parseDate value = "${promo.startDate }" pattern="yyyy-MM-dd HH:mm:ss" var = "startDate"></fmt:parseDate>
	                                <div class="startDate_voucher"><fmt:formatDate value="${startDate}" pattern="dd-MM-yyyy"/></div>
	                                <fmt:parseDate value = "${promo.endDate }" pattern="yyyy-MM-dd HH:mm:ss" var = "endDate"></fmt:parseDate>
	                                <div class="endDate_voucher"><fmt:formatDate value="${endDate}" pattern="dd-MM-yyyy"/></div>
	                                <div class="minOrder_voucher"><fmt:formatNumber type = "number" pattern = "###">${promo.minimumPay }</fmt:formatNumber> VNĐ</div>
	                                <div class="update_voucher btn-edit" idPromo = "${promo.id}"><a href = "adminEditVoucher?id=${promo.id }"><i class="fa-solid fa-pen-to-square"></i></a></div>
	                                <div class="delete_voucher btn-xoa" idPromo = "${promo.id}" ><i class="fa-solid fa-trash deleteVoucher"></i></div>
	                            </div>
                            </c:forEach>  
                        </div>
                        <div class="footer_voucher">

                        </div>
                    </div>
                </div>
                <div class="deleteItem">
                    <div class="deleteAlert">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <div class="deleteAlert_label">Bạn muốn xoá voucher này ?</div>
                        <div class="deleteOpt">
                            <button class="delOpt_no">Không</button>
                            <button class="delOpt_yes">Có</button>
                        </div>
                    </div>
                </div>
            </div>
         </div>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>               
        <script src = "js/adminManagePromo.js"></script>
    </body>
</html>        