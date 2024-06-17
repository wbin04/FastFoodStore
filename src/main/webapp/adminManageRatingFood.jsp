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
                <div class="managerRating_form">
                    <div class="general_rating">
                        <div class="back rating_back">
                            <a href = "ManageFoodDetail?id=${requestScope.idFood}">
                                <i class="fa-solid fa-arrow-left"></i>
                                Quay lại
                            </a>
                        </div>
                        <div class="rating_prodName">Gà vui vẻ</div>
                        <div class="rating_overview">
                            <div class="overview_star">
                                <div class="overview_nullStar">
                                    <i class="fa-regular fa-star"></i>
                                    <i class="fa-regular fa-star"></i>
                                    <i class="fa-regular fa-star"></i>
                                    <i class="fa-regular fa-star"></i>
                                    <i class="fa-regular fa-star"></i>
                                </div>
                                <div class="overview_numStar" averageStar = "${requestScope.totalStar / requestScope.ratingQuantity}" >
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                </div>
                            </div>
                            <div class="overview_averageStar">
                            	<fmt:formatNumber type = "number" pattern = "#.#" value = "${requestScope.totalStar / requestScope.ratingQuantity}" var = "averageStar"/>
                                ${averageStar} / 5
                            </div>
                            <div class="overview_total">
                                ${requestScope.ratingQuantity} lượt đánh giá
                            </div>
                            <div class="overview_detail">
                                <div class="item_star">
                                    <b>5</b>
                                    <i class="fa-solid fa-star"></i>
                                    <div class="bar">
                                        <c:set var = "percent5Star" value = "${100 * requestScope.arr5Star / requestScope.ratingQuantity }" />
                                        <div class="quantity_bar" id="quantity_5star" style = "width: ${percent5Star}%" ></div>
                                    </div>
                                    (<div class="quantity_count count_5star">${requestScope.arr5Star }</div>)
                                </div>
                                <div class="item_star">
                                    <b>4</b>
                                    <i class="fa-solid fa-star"></i>
                                    <div class="bar">
                                    	<c:set var = "percent4Star" value = "${100 * requestScope.arr4Star / requestScope.ratingQuantity }" />
                                        <div class="quantity_bar" id="quantity_4star" style = "width: ${percent4Star}%"></div>
                                    </div>
                                    (<div class="quantity_count count_4star">${requestScope.arr4Star }</div>)
                                </div>
                                <div class="item_star">
                                    <b>3</b>
                                    <i class="fa-solid fa-star"></i>
                                    <div class="bar">
                                        <c:set var = "percent3Star" value = "${100 * requestScope.arr3Star / requestScope.ratingQuantity }" />
                                        <div class="quantity_bar" id="quantity_3star" style = "width: ${percent3Star}%"></div>
                                    </div>
                                    (<div class="quantity_count count_3star">${requestScope.arr3Star }</div>)
                                </div>
                                <div class="item_star">
                                    <b>2</b>
                                    <i class="fa-solid fa-star"></i>
                                    <div class="bar">
                                    	<c:set var = "percent2Star" value = "${100 * requestScope.arr2Star / requestScope.ratingQuantity }" />
                                        <div class="quantity_bar" id="quantity_2star" style = "width: ${percent2Star}%"></div>
                                    </div>
                                    (<div class="quantity_count count_2star">${requestScope.arr2Star }</div>)
                                </div>
                                <div class="item_star">
                                    <b>1</b>
                                    <i class="fa-solid fa-star"></i>
                                    <div class="bar">
                                    	<c:set var = "percent1Star" value = "${100 * requestScope.arr1Star / requestScope.ratingQuantity }" />
                                        <div class="quantity_bar" id="quantity_1star" style = "width: ${percent1Star}%"></div>
                                    </div>
                                    (<div class="quantity_count count_1star">${requestScope.arr1Star }</div>)
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container_rating">
                        <div class="label_rating">Đánh giá</div>
                        <div class="list_rating">
                            <c:forEach items = "${requestScope.listRatingDetail}" var = "rd">
                            	<div class = "rating_item">
	                            	<div class = "rating_header">
	                            		<div class = "rating_username">${rd.username }</div>
	                            		<div class = "rating_numStar" point = "${rd.point}">${rd.point}</div>
	                            	</div>
	                            	<div class = "rating_body">
	                            		<textarea readonly class="rating_content" rows="1">${rd.content}</textarea>
	                            	</div>
	                            </div>
                            </c:forEach>
                            
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>   
        <script>
	        document.querySelectorAll('.rating_numStar').forEach(function(element) {
	        	var point = parseInt(element.getAttribute('point'));
	            showStarNumber(point, element);
	        });
        	
	        const overview_numStar = document.querySelector('.overview_numStar');
	        const averageStar = overview_numStar.getAttribute('averageStar');
	        showStarNumber(averageStar, overview_numStar);
	        
	        function showStarNumber (num, container){ // moithem
	        	container.innerHTML = '';
	            let temp;
	            if(num == parseInt(num)){
	                temp = num;
	            }
	            else temp = parseInt(num);
	            for (let i = 1; i <= num; i++) {
	                container.innerHTML += `<i class="fa-solid fa-star"></i>`;
	            }
	            let odd = parseFloat(num - temp);
	            if(odd > 0){
	            	container.innerHTML += `<i class="fa-solid fa-star clipPath"></i>`;
	                odd = odd * 100;
	                const percent = odd + "%";
	                console.log(percent);
	                const clipPath = container.querySelector('.clipPath');
	                clipPath.style.setProperty('--value', percent);
	                temp++;
	            }
	            for (let i = 5-temp; i>0; i--){
	                container.innerHTML += `<i class="fa-regular fa-star"></i>`;
	            }
	        }
        </script>
    </body>
</html>        