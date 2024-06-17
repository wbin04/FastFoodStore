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
        <link rel="stylesheet" href="css/base.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/payment1.css">
        <link rel="stylesheet" href="css/scroll_bar.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap">
        <title>Thanh toán</title>
    </head>
    <body>
        <div id="pay_success">
            <div class="paySuccess_back">
                <a href="home">
                    <i class="fa-solid fa-arrow-left"></i>
                    Trang chủ
                </a>
            </div>
            <i class="fas fa-times-circle payFailed_icon"></i>
            <div class="paySuccess_lable">Đặt hàng thất bại</div>
            <div class="paySuccess_orderCode"></div>
            <div class="paySuccess_opt">
                <a href="menu" class="homeOpt">Tiếp tục mua sắm</a>
                <a href="orderManage" class="accountOpt">Theo dõi đơn hàng</a>
            </div>
        </div>
        <!-- <script src="script.js" type="module"></script> -->
         <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/payment.js"></script>
      
    </body>
</html>