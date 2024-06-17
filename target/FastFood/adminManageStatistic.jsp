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
                    <div class="manager_orderType" style="display: none;">
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
                            <a href = "adminManageOrders?type=3">Đã giao hàng</a>
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
            <div class="col_info">
            	<div class="managerCounting_form">
                    <div class="counting_header">
                        <div class="datepicker">
                            <div class="datepicker_label">Doanh thu ngày:</div>
                            <div class="datepicker_box">
                                <div class="datepicker_showDate"></div>
                                <i class="fa-solid fa-calendar-days pickDate"></i>
                            </div>
                        </div>
                    </div>
                    <div class="counting_sale">
                        <div class="count_filter filterProdQuantity">
                            <div class="filter_name">Số sản phẩm đã bán</div>
                            <div class="filter_quantity setProdQuantity"></div>
                        </div>
                        <div class="count_filter filterUserQuantity">
                            <div class="filter_name">Số khách hàng đã mua</div>
                            <div class="filter_quantity setUserQuantity"></div>
                        </div>
                        <div class="count_filter filterOrderQuantity">
                            <div class="filter_name">Số đơn hàng đã đặt</div>
                            <div class="filter_quantity setOrderQuantity"></div>
                        </div>
                        <div class="count_filter filterTotalPrice">
                            <div class="filter_name">Tổng doanh thu</div>
                            <div class="filter_quantity setTotalPrice"></div>
                        </div>
                    </div>
                    <div class="counting_overview">
                        <div class="overview_chart">
                            <div class="datefilter">
                                <div class="datefilter_label">Thống kê theo:
                                    <select id="date_filter" name="date" class="datefilter_option" onchange="showChart(this)">
                                        <option value="day">Ngày</option>
                                        <option value="week">Tuần</option>
                                       <!--  <option value="month">Tháng</option> -->
                                        <option value="year">Năm</option>
                                    </select>
                                </div>
                            </div>
                            <canvas id="counting_chart" width="400" height="200"></canvas>
                        </div>
                        <div class="overview_bestSeller">
                            <div class="col_bestSeller">
	                            <div class="bestSeller_label">Sản phẩm bán chạy</div>
	                            <div class="bestSeller_list">
	                                <c:forEach items = "${requestScope.listBestSellerFood }" var = "f">
	                                	<div class="bestSeller_item">
		                                    <div class="itemContainer_img">
		                                        <img src="${f.image }" alt="" class="bestSeller_img">
		                                    </div>
		                                    <div class="itemContainer_info">
		                                        ${f.title }
		                                    </div>
		                                </div>
	                                </c:forEach>
	                            </div>
	                        </div>    
	                        <div class="col_typeChart">
	                                <canvas id="counting_typeChart" width="400" height="200"></canvas>
	                        </div>    
                        </div>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/autosize.js/4.0.2/autosize.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Tìm tất cả các thẻ <textarea> mà bạn muốn áp dụng auto-resize
                var textareas = document.querySelectorAll('textarea');
    
                // Áp dụng autosize cho mỗi <textarea>
                autosize(textareas);
            });
        </script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.js" integrity="sha512-ZwR1/gSZM3ai6vCdI+LVF1zSq/5HznD3ZSTk7kajkaj4D292NLuduDCO1c/NT8Id+jE58KYLKT7hXnbtryGmMg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="js/adminManageStatistic.js"></script>    
    </body>
</html>   