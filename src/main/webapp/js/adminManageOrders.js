const orderStatusElement = document.querySelectorAll('.orderStatus')

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

$(document).ready(function(){
	$('.optCancel').click(function(){
		var status = "Đã huỷ"
		var orderId = $(this).attr("orderId")
		var currentStatusDiv = $(".orderStatus");
		$.ajax({
	        method: "POST",
	        url: "http://localhost:8080/FastFood/api/order/changeStatus",
	        data: { status: status, orderId: orderId}
	    }).done(function(data) {
	        currentStatusDiv.text(status);
	        changeStatusOption(status);
	        orderStatus.style.color = '#FF3213'
	        alert("Đã huỷ đơn hàng thành công");

	    }).fail(function(xhr, status, error) {
	        alert("Đã xảy ra lỗi: " + error);
	        console.error(xhr, status, error);
	    });
	})
	
	$('.optConfirm').click(function(){
		var status = "Đang vận chuyển"
		var orderId = $(this).attr("orderId")
		var currentStatusDiv = $(".orderStatus");
		$.ajax({
	        method: "POST",
	        url: "http://localhost:8080/FastFood/api/order/changeStatus",
	        data: { status: status, orderId: orderId}
	    }).done(function(data) {
			currentStatusDiv.text(status);
			changeStatusOption(status);
			orderStatus.style.color = '#FF971C'
	        alert("Đã xác nhận đơn hàng thành công");
	        
	    }).fail(function(xhr, status, error) {
	        alert("Đã xảy ra lỗi: " + error);
	        console.error(xhr, status, error);
	    });
	})
	$('.optDone').click(function(){
		var status = "Đã hoàn thành"
		var orderId = $(this).attr("orderId")
		var currentStatusDiv = $(".orderStatus");
		$.ajax({
	        method: "POST",
	        url: "http://localhost:8080/FastFood/api/order/changeStatus",
	        data: { status: status, orderId: orderId}
	    }).done(function(data) {
			currentStatusDiv.text(status);
			changeStatusOption(status);
			orderStatus.style.color = '#72CB3B'
	        alert("Đã hoàn thành đơn hàng ");
	        
	    }).fail(function(xhr, status, error) {
	        alert("Đã xảy ra lỗi: " + error);
	        console.error(xhr, status, error);
	    });
	})
	const optDone = document.querySelector('.optDone'); // moithem --------- co sua lai toi het ham
	const optConfirm = document.querySelector('.optConfirm');
    const optCancel = document.querySelector('.optCancel');

    // const hideButton = managerOrderDetailForm.querySelector('.orderBtnOption');
    const orderDetail_body = document.querySelector('.orderDetail_body');
    const orderStatus = document.querySelector('.orderStatus');
    function changeStatusOption(status){
		if(orderStatus.textContent === 'Chờ xác nhận'){
	        optConfirm.style.display = 'flex';
	        optCancel.style.display = 'flex';
	        optDone.style.display = 'none';
	        orderDetail_body.style.height = '72.5%%';
	        orderDetail_body.style.borderBottom = '2px solid rgba(0,0,0,0.1)';
	    }
	    else if(orderStatus.textContent === 'Đang vận chuyển'){
	        optConfirm.style.display = 'none';
	        optCancel.style.display = 'none';
	        optDone.style.display = 'flex';
	        orderDetail_body.style.height = '72.5%%';
	        orderDetail_body.style.borderBottom = '2px solid rgba(0,0,0,0.1)';
	        optConfirm.style.display = 'none'
	    }
	    else{ 
	        optConfirm.style.display = 'none';
	        optCancel.style.display = 'none';
	        optDone.style.display = 'none';
	        orderDetail_body.style.height = '80%';
	        orderDetail_body.style.borderBottom = '2px solid rgba(0,0,0,0.1)';
	    }
	}
	
	if(orderStatus.textContent === 'Chờ xác nhận'){
	        optConfirm.style.display = 'flex';
	        optCancel.style.display = 'flex';
	        optDone.style.display = 'none';
	        orderDetail_body.style.height = '72.5%%';
	        orderDetail_body.style.borderBottom = '2px solid rgba(0,0,0,0.1)';
	    }
	    else if(orderStatus.textContent === 'Đang vận chuyển'){
	        optConfirm.style.display = 'none';
	        optCancel.style.display = 'none';
	        optDone.style.display = 'flex';
	        orderDetail_body.style.height = '72.5%%';
	        orderDetail_body.style.borderBottom = '2px solid rgba(0,0,0,0.1)';
	        optConfirm.style.display = 'none'
	    }
	    else{ 
	        optConfirm.style.display = 'none';
	        optCancel.style.display = 'none';
	        optDone.style.display = 'none';
	        orderDetail_body.style.height = '80%';
	        orderDetail_body.style.borderBottom = '2px solid rgba(0,0,0,0.1)';
	    }
    
})
