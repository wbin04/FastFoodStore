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
                        <a href = "adminManageFood">Quản lý đơn hàng</a>
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
                <div class="managerAddProduct_form">
                    <div class="back product_back">
                        <a href = "adminManageFood">
                            <i class="fa-solid fa-arrow-left"></i>
                            Quay lại
                        </a>
                    </div>
                    <div class="prodInfo_set addProdLabel">Thông tin sản phẩm mới</div>
                    <div class="addProduct_container">
                        <div class="addProdContainer_img">  
                            <!-- <form action = "uploadImage" method = "post" enctype = "multipart/form-data"> -->
                            	<div class="setAddProdImage">
	                                <img src="" alt="" class="img_addProd" id = "img_addProdShow">
	                            </div> 
                            	<div class = "form-group">
                            		<input type = "file" class = "form-control" name = "photo" id = "photoInput">	
                            	</div>
                            	<!-- <button type = "button" class="addImage">Hiển thị ảnh</button> -->
                            <!-- </form>  -->                    
                        </div>
                        <div class="addProdContainer_info">
                            <!-- <div class="addProdInfo_set prodID">
                                <div class="addProdID_label">Mã sản phẩm</div>
                                <input readonly type="text" name="" id="" class="setAddProdID">
                            </div> -->
                            <div class="addProdInfo_set prodName">
                                <div class="addProdName_label">Tên sản phẩm</div>
                                <input type="text" name="" id="" class="setAddProdName">
                            </div>
                            <div class="addProdInfo_set prodDesc">
                                <div class="addProdDesc_label">Mô tả</div>
                                <input type="text" name="" id="" class="setAddProdDesc">
                            </div>
                            <div class="addProdInfo_set prodPrice">
                                <div class="addProdPrice_label">Giá</div>
                                <input type="text" name="" id="" class="setAddProdPrice">
                            </div>
                            <div class="prodInfo_set prodType">
                                <div class="prodType_label">Loại</div>
                                <div class="addProdType_set">
                                	<select name = "product_type" class = "setAddProdType">
                                		<c:forEach items = "${requestScope.listCate}" var = "c">
                                			<option value = "${c.cateName}">${c.cateName}</option>
                                		</c:forEach>
                                	</select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="addOption">
                        <!-- <a class="optEdit">Thay đổi thông tin sản phẩm</a>
                        <button class="optSave">Lưu thay đổi</button>
                        <button class="optDel">Xoá sản phẩm</button> -->
                        <button class="optAdd">Thêm sản phẩm</button>
                    </div>
                </div>
                <div class="confirmAdd_productEmpty">
	                <div class="confirmAlert">
	                    <i class="fa-solid fa-circle-exclamation"></i>
	                    <div class="confirmAlert_label">
	                        <p>Vui lòng điền đầy đủ thông tin sản phẩm</p>
	                        <p>và tải lên hình ảnh.</p>
	                    </div>
	                    <div class="confirmOpt">
	                        <button class="confirmOpt_yes">OK</button>
	                    </div>
	                </div>
	            </div>
	            <div class="confirmAdd_product">
	                <div class="confirmAlert">
	                    <i class="fa-solid fa-circle-exclamation"></i>
	                    <div class="confirmAlert_label">Bạn muốn thêm sản phẩm này ?</div>
	                    <div class="confirmOpt">
	                        <button class="confirmOpt_no">Không</button>
	                        <button class="confirmOpt_yes">Có</button>
	                    </div>
	                </div>
	            </div>
            </div>
        </div>    
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>    
        <script src="js/adminAddFood.js"></script>
    </body>
</html>        