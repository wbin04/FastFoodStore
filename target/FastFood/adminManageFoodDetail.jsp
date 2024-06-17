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
                <div class="managerProductDetail_form">
                    <div class="back product_back">
                        <a href = "adminManageFood">
                            <i class="fa-solid fa-arrow-left"></i>
                            Quay lại
                        </a>
                    </div>
                    <c:set var = "f" value = "${requestScope.food }"/>
                    <div class="prodInfo_set prodLabel">Thông tin sản phẩm</div>
                    <div class="product_container">
                        <div class="prodContainer_img">
                            <div class="setProdImage">
                                <img src="${f.image }" alt="" class="img_detailProd" id = "img_detailProdShow">
                            </div>
                            <!-- <button class="changeImage">Thay đổi hình ảnh</button> -->
                            <div class = "form-group" style = "display: none">
                            		<input type = "file" class = "form-control" name = "photo" id = "photoInput">	
                            </div>
                        </div>
                        <div class="prodContainer_info">
                            <div class="prodInfo_set prodID">
                                <div class="prodID_label">Mã sản phẩm</div>
                                <input readonly type="text" name="" id="" class="setProdID" value = "${f.id }" >
                            </div>
                            <div class="prodInfo_set prodName">
                                <div class="prodName_label">Tên sản phẩm</div>
                                <input readonly type="text" name="" id="" class="setProdName" value = "${f.title }">
                            </div>
                            <div class="prodInfo_set prodDesc">
                                <div class="prodDesc_label">Mô tả</div>
                                <input readonly type="text" name="" id="" class="setProdDesc" value = "${f.description }">
                            </div>
                            <div class="prodInfo_set prodPrice">
                                <div class="prodPrice_label">Giá</div>
                                <input readonly type="text" name="" id="" class="setProdPrice" value = "${f.price }">
                            </div>
                            <c:set var = "cateId" value = "${f.cateId }"/>
                            <div class="prodInfo_set prodType">
                                <div class="prodType_label">Loại</div>
                               	<select name="product_type" class="setProdType" disabled>
								    <c:forEach items="${requestScope.listCate}" var="c" varStatus = "loop">
								        <option value="${c.cateName}" <c:if test="${loop.index == cateId - 1}">selected</c:if>>${c.cateName}</option>
								    </c:forEach>
								</select>
                            </div>
                        </div>
                    </div>
                    <div class="changeOption">
                    	<button class="optRating"><a href = "ManageRatingFood?foodId=${f.id}">Xem đánh giá</a></button>
                        <button class="optEdit">Thay đổi thông tin</button>
                        <button class="optSave">Lưu thay đổi</button>
                        <button class="optDel">Xoá sản phẩm</button>
                    </div>
                </div>
            </div>
            
            <div class="confirmDelete_product">
                <div class="confirmAlert">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <div class="confirmAlert_label">Bạn muốn xoá sản phẩm này ?</div>
                    <div class="confirmOpt">
                        <button class="confirmOptDel_no">Không</button>
                        <button class="confirmOptDel_yes">Có</button>
                    </div>
                </div>
            </div>
            
            <div class="confirmUpdate_product">
                <div class="confirmAlert">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <div class="confirmAlert_label">Bạn muốn cập nhật sản phẩm này ?</div>
                    <div class="confirmOpt">
                        <button class="confirmOptEdit_no">Không</button>
                        <button class="confirmOptEdit_yes">Có</button>
                    </div>
                </div>
            </div>
            
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>   
        <script src="js/ManageFoodDetail.js"></script>
    </body>
</html>        