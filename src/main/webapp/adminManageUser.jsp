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
            <div class="col_info">
                <div class="managerUser_form">
                    <div class="header_form">
                        <div class="search_bar">
                            <input type="text" class="search_text" placeholder="Tìm khách hàng...">
                            <button class="search_icon">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </div>
                    <div class="form_detail">
                        <div class="desc_form desc_user">
                            <div class="id_user">ID</div>
                            <div class="name_user">Tên người dùng</div>
                            <div class="phone_user">Số điện thoại</div>
                            <div class="email_user">Email</div>
                            <div class="detail_user">Chi tiết</div>
                        </div>
                        <div class="list_user">
                            <c:forEach items = "${requestScope.listUser }" var = "u">
                            	<div class="userItem">
	                                <div class="id_user">${u.id }</div>
	                                <div class="name_user">${u.fullname }</div>
	                                <div class="phone_user">${u.phoneNumber }</div>
	                                <div class="email_user">${u.email }</div>
	                                <div class="detail_user">
	                                	<a href = "ManageUserDetail?id=${u.id}"><i class="fa-solid fa-magnifying-glass detailUser"></i></a>
	                                </div>
                            	</div>
                            </c:forEach>
                        </div>
                        <div class="footer_user">
                        </div>
                    </div>
                </div>
                <!-- <div class="managerUserDetail_form">
                    <div class="back user_back">
                        <a>
                            <i class="fa-solid fa-arrow-left"></i>
                            Quay lại
                        </a>
                    </div>
                    <div class="accInfo_set accLabel">Thông tin tài khoản</div>
                    <div class="accInfo_set accID">
                        <div class="accID_label">Mã khách hàng</div>
                        <input readonly type="text" name="" id="" class="setAccID">
                    </div>
                    <div class="accInfo_set accName">
                        <div class="accName_label">Họ tên</div>
                        <input readonly type="text" name="" id="" class="setAccName">
                    </div>
                    <div class="accInfo_set accNameUser">
                        <div class="accNameUser_label">Tên tài khoản</div>
                        <input readonly type="text" name="" id="" class="setAccNameUser">
                    </div>
                    <div class="accInfo_set accPhone">
                        <div class="accPhone_label">Số điện thoại</div>
                        <input readonly type="text" name="" id="" class="setAccPhone">
                    </div>
                    <div class="accInfo_set accEmail">
                        <div class="accEmail_label">Email</div>
                        <input readonly type="text" name="" id="" class="setAccEmail">
                    </div>
                    <div class="accInfo_set accAddress">
                        <div class="accAddress_label">Địa chỉ</div>
                        <input readonly type="text" name="" id="" class="setAccAddress">
                    </div>
                    <div class="accInfo_set deleteUser">
                        <a href="" class="changePassword">Đổi mật khẩu</a>
                        <button class="delUserBtn">Xoá tài khoản</button>
                    </div>
                </div> -->
            </div>
            <!-- <div class="confirmDelete_user">
                <div class="confirmAlert">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <div class="confirmAlert_label">Bạn muốn xoá khách hàng này ?</div>
                    <div class="confirmOpt">
                        <button class="confirmOpt_no">Không</button>
                        <button class="confirmOpt_yes">Có</button>
                    </div>
                </div>
            </div> -->
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/adminManageUser.js"></script>
    </body>
</html>    