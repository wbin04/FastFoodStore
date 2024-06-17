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
            <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
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
            <div class="col_info">
                <div class="managerUpdateVoucher_form">
                    <div class="back upVoucher_back">
                        <a href = "adminManagePromo">
                            <i class="fa-solid fa-arrow-left"></i>
                            Quay lại
                        </a>
                    </div>
                    <div class="addVoucherLabel">Thông tin mã giảm giá</div>
                    <c:set var = "p" value = "${requestScope.promo }"/>
                    <div class="addVoucher_container">
                        <div class="addVoucher_set">
                            <div class="voucher_label">ID mã</div>
                            <input type="text" name="" id="" class="setVoucher_ID" value = "${p.id }" disabled>
                            <!-- <div class="voucherVND">VNĐ</div> -->
                        </div>
                        <div class="addVoucher_set">
                            <div class="voucher_label">Giảm giá</div>
                            <input type="text" name="" id="" class="setVoucher_discount" value = "${p.percent }">
                            <div class="voucherVND">VNĐ</div>
                        </div>
                        <div class="addVoucher_set">
                            <div class="voucher_label">Đơn tối thiểu</div>
                            <input type="text" name="" id="" class="setVoucher_minOrder" value = "${p.minimumPay}">
                            <div class="voucherVND">VNĐ</div>
                        </div>
                        <!-- datepicker css trong admin_counting.css -->
                        <div class="addVoucher_set">
                            <div class="voucher_label">Ngày bắt đầu</div>
                            <div class="datepicker_box">
                                <div class="datepicker_showStartDate"></div>
                                <i class="fa-solid fa-calendar-days pickDate pickStartDate"></i>
                            </div>
                        </div>
                        <div class="addVoucher_set">
                            <div class="voucher_label">Ngày kết thúc</div>
                            <div class="datepicker_box">
                                <div class="datepicker_showEndDate"></div>
                                <i class="fa-solid fa-calendar-days pickDate pickEndDate"></i>
                            </div>
                        </div>
                    </div>
                    <!-- css tại admin_product.css -->
                    <div class="addOption">
                        <button class="optSave option_upVoucherBtn">Lưu thay đổi</button>
                    </div>
                </div>
            </div>
            <div id="showCalendar">
               <div class="calendar_container">
                   <div class="calendar_header">
                     <p class="current-date"></p>
                     <div class="icons">
                       <span id="prev" class="material-symbols-rounded">chevron_left</span>
                       <span id="next" class="material-symbols-rounded">chevron_right</span>
                     </div>
                   </div>
                   <div class="calendar">
                     <ul class="weeks">
                       <li>CN</li>
                       <li>T2</li>
                       <li>T3</li>
                       <li>T4</li>
                       <li>T5</li>
                       <li>T6</li>
                       <li>T7</li>
                     </ul>
                     <ul class="days"></ul>
                   </div>
               </div>
           </div>
         </div>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>               
        <script src = "js/adminEditVoucher.js"></script>
    </body>
</html>        