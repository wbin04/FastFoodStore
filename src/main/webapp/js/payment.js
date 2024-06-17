// const optPayMethod = document.querySelector('.optPayMethod')
// const customerNameInput = document.querySelector('.customerName')
// const customerPhoneInput = document.querySelector('.customerPhone')
// const customerAddressInput = document.querySelector('.customerAddress')
// const optEditLink = document.querySelector('.optEdit');
// const optSaveBtn = document.querySelector('.optSave');
// const optPayBtn = document.querySelector('.payBtn');
// const overlay_voucher = document.querySelector('.overlay_voucher');
// const cancel_voucher = document.querySelector('.cancel_voucher');
// const show_Voucher = document.querySelector('.show_Voucher');
// const discountCodeInput = document.querySelector('.discountCodeInput');
// const billTotalCost = document.querySelector('.billTotalPrice')
// let discountId = '';
// let discountCodeInput_value;
// let discountValue = 0;
// let isEdit = false;
// $(document).ready(function(){
// 	function submitOrder() {
//         var noteInput = document.querySelector('.noteInput');
//         var paymentMethod = optPayMethod.value;
//         var customerName = customerNameInput.value;
//         var customerPhone = customerPhoneInput.value;
//         var customerAddress = customerAddressInput.value;
//         var note = noteInput.value;
//         var totalCost = parseInt(billTotalCost.textContent.replace(/\D/g, ''));

//         switch(optPayMethod.value) {
//             case 'COD':
//                 $.ajax({
//                     method: "POST",
//                     url: "http://localhost:8080/FastFood/api/order/add",
//                     data: {
//                         totalCost: totalCost,
//                         note: note,
//                         paymentMethod: paymentMethod,
//                         receiverName: customerName,
//                         shipAddress: customerAddress,
//                         phoneNumber: customerPhone,
//                         idPromo: discountId,
//                         discount: discountValue
//                     }
//                 }).done(function(data) {
//                     window.location.href = "http://localhost:8080/FastFood/payment-success";
//                 }).fail(function(xhr, status, error) {
//                     alert("Đã xảy ra lỗi: " + error);
//                     console.error(xhr, status, error);
//                 });
//                 break;
//             case 'VNPAY':
//                 $.ajax({
//                     method: "GET",
//                     url: "http://localhost:8080/FastFood/api/vnpay",
//                     data: {
//                         totalCost: totalCost,
//                         note: note,
//                         paymentMethod: paymentMethod,
//                         receiverName: customerName,
//                         shipAddress: customerAddress,
//                         phoneNumber: customerPhone,
//                         discount: discountValue,
//                         idPromo: discountId
//                     }
//                 }).done(function(res) {
// 					window.location.href = res.data;
// 					console.log(res.data);
// 					/*$.ajax({
// 						method: "POST",
// 						url: "http://localhost:8080/FastFood/api/order/discount",
// 						data: {
// 							totalCost: totalCost,
// 							note: note,
// 							paymentMethod: paymentMethod,
// 							receiverName: customerName,
// 							shipAddress: customerAddress,
// 							phoneNumber: customerPhone,
// 							discount: discountValue
// 						}
// 					}).done(function(data) {
// 						alert('Successfully');
// 					}).fail(function(xhr, status, error) {
// 						alert("Đã xảy ra lỗi: api order discount" + error);
// 						console.error(xhr, status, error);
// 					});*/
//                 }).fail(function(xhr, status, error) {
//                     alert("Đã xảy ra lỗi: api vnpay " + error);
//                 });
//                 break;
//         }
//     }
	
	
//     $('.payBtn').click(function() {
//         if(isEdit) {
//             const updateItem = document.querySelector('.updateItem');
//             updateItem.style.display = 'flex';
//             $('.updateOpt_yes').off('click').on('click', function() {
//                 var customerName = customerNameInput.value;
//                 var customerPhone = customerPhoneInput.value;
//                 var customerAddress = customerAddressInput.value;
//                 $.ajax({
//                     method: "POST",
//                     url: "http://localhost:8080/FastFood/api/user/update",
//                     data: {
//                         fullname: customerName,
//                         phoneNumber: customerPhone,
//                         address: customerAddress
//                     }
//                 }).done(function(data) {
//                     customerNameInput.setAttribute('readonly', true);
//                     customerPhoneInput.setAttribute('readonly', true);
//                     customerAddressInput.setAttribute('readonly', true);
//                     optSaveBtn.style.display = 'none';
//                     optPayBtn.style.display = 'block';
//                     updateItem.style.display = 'none';
//                     isEdit = false;
//                     submitOrder(); 
//                 }).fail(function(xhr, status, error) {
//                     alert("Đã xảy ra lỗi: api user update" + error);
//                     console.error(xhr, status, error);
//                 });
//             });
//             $('.updateOpt_no').off('click').on('click', function() {
//                 updateItem.style.display = 'none';
//                 submitOrder();
//             });
//         } else {
//             submitOrder();
//         }
//     });
	
// 	$('.optEdit').click(function(){
// 		customerNameInput.removeAttribute('readonly');
// 		customerPhoneInput.removeAttribute('readonly');
// 		customerAddressInput.removeAttribute('readonly');
// 		customerNameInput.focus();
// 		isEdit = true;
// 	})
	
// 	cancel_voucher.addEventListener('click', () => {
// 	    overlay_voucher.style.display = 'none';
// 	});
	
// 	show_Voucher.addEventListener('click', () => {
// 	    overlay_voucher.style.display = 'flex';
// 	});
// 	$('.voucher_get').click(function(){
// 		let discount = $(this).attr('discount');
// 		discountValue = discount; // Lưu giá trị giảm giá
// 		discountCodeInput.value = `- ${discount} VNĐ`;
// 		discountId = $(this).attr('idPromo');
//         overlay_voucher.style.display = 'none';
//         let currentTotalCost = billTotalCost.textContent;
//         billTotalCost.textContent = parseInt(currentTotalCost) - discount + ' VNĐ';
// 	})
	
// })

// function filterProducts() {
//    	var input = document.getElementById('search_input');
// 	var filter = input.value.toLowerCase();
// 	var vouchers = document.getElementsByClassName('voucher_item');
// 	console.log(vouchers[0].getAttribute('id'))
// 	for (var i = 0; i < vouchers.length; i++) {
// 	    var id = vouchers[i].getAttribute('id').toLowerCase();
	    
// 	    if (id.indexOf(filter) > -1) {
// 	         vouchers[i].style.display = '';
// 	    } else {
// 	        vouchers[i].style.display = 'none';
// 	    }
// 	}
// }

const optPayMethod = document.querySelector('.optPayMethod')
const customerNameInput = document.querySelector('.customerName')
const customerPhoneInput = document.querySelector('.customerPhone')
const customerAddressInput = document.querySelector('.customerAddress')
const optEditLink = document.querySelector('.optEdit');
const optSaveBtn = document.querySelector('.optSave');
const optPayBtn = document.querySelector('.payBtn');
const overlay_voucher = document.querySelector('.overlay_voucher');
const cancel_voucher = document.querySelector('.cancel_voucher');
const show_Voucher = document.querySelector('.show_Voucher');
const discountCodeInput = document.querySelector('.discountCodeInput');
const billTotalCost = document.querySelector('.billTotalPrice')
let discountId = '';
let discountCodeInput_value;
let discountValue = 0;
let isEdit = false;
$(document).ready(function(){
	function submitOrder() {
        var noteInput = document.querySelector('.noteInput');
        var paymentMethod = optPayMethod.value;
        var customerName = customerNameInput.value;
        var customerPhone = customerPhoneInput.value;
        var customerAddress = customerAddressInput.value;
        var note = noteInput.value;
        var totalCost = parseInt(billTotalCost.textContent.replace(/\D/g, ''));

        switch(optPayMethod.value) {
            case 'COD':
                $.ajax({
                    method: "POST",
                    url: "http://localhost:8080/FastFood/api/order/add",
                    data: {
                        totalCost: totalCost,
                        note: note,
                        paymentMethod: paymentMethod,
                        receiverName: customerName,
                        shipAddress: customerAddress,
                        phoneNumber: customerPhone,
                        idPromo: discountId,
                        discount: discountValue
                    }
                }).done(function(data) {
					$('.payBtn').prop('disabled', false);
                    window.location.href = "http://localhost:8080/FastFood/payment-success";
                }).fail(function(xhr, status, error) {
                    alert("Đã xảy ra lỗi: " + error);
                    console.error(xhr, status, error);
                });
                break;
            case 'VNPAY':
                $.ajax({
                    method: "GET",
                    url: "http://localhost:8080/FastFood/api/vnpay",
                    data: {
                        totalCost: totalCost,
                        note: note,
                        paymentMethod: paymentMethod,
                        receiverName: customerName,
                        shipAddress: customerAddress,
                        phoneNumber: customerPhone,
                        discount: discountValue,
                        idPromo: discountId
                    }
                }).done(function(res) {
					$('.payBtn').prop('disabled', false);
					window.location.href = res.data;
					console.log(res.data);
					/*$.ajax({
						method: "POST",
						url: "http://localhost:8080/FastFood/api/order/discount",
						data: {
							totalCost: totalCost,
							note: note,
							paymentMethod: paymentMethod,
							receiverName: customerName,
							shipAddress: customerAddress,
							phoneNumber: customerPhone,
							discount: discountValue
						}
					}).done(function(data) {
						alert('Successfully');
					}).fail(function(xhr, status, error) {
						alert("Đã xảy ra lỗi: api order discount" + error);
						console.error(xhr, status, error);
					});*/
                }).fail(function(xhr, status, error) {
                    alert("Đã xảy ra lỗi: api vnpay " + error);
                });
                break;
        }
    }
	
	
    $('.payBtn').click(function() {
        if(isEdit) {
            const updateItem = document.querySelector('.updateItem');
            updateItem.style.display = 'flex';
            $('.updateOpt_yes').off('click').on('click', function() {
				$('.payBtn').prop('disabled', true);
                var customerName = customerNameInput.value;
                var customerPhone = customerPhoneInput.value;
                var customerAddress = customerAddressInput.value;
                $.ajax({
                    method: "POST",
                    url: "http://localhost:8080/FastFood/api/user/update",
                    data: {
                        fullname: customerName,
                        phoneNumber: customerPhone,
                        address: customerAddress
                    }
                }).done(function(data) {
                    customerNameInput.setAttribute('readonly', true);
                    customerPhoneInput.setAttribute('readonly', true);
                    customerAddressInput.setAttribute('readonly', true);
                    optSaveBtn.style.display = 'none';
                    optPayBtn.style.display = 'block';
                    updateItem.style.display = 'none';
                    isEdit = false;
                    submitOrder(); 
                }).fail(function(xhr, status, error) {
                    alert("Đã xảy ra lỗi: api user update" + error);
                    console.error(xhr, status, error);
                });
            });
            $('.updateOpt_no').off('click').on('click', function() {
				$('.payBtn').prop('disabled', true);
                updateItem.style.display = 'none';
                submitOrder();
            });
        } else {
			$('.payBtn').prop('disabled', true);
            submitOrder();
        }
    });
	
	$('.optEdit').click(function(){
		customerNameInput.removeAttribute('readonly');
		customerPhoneInput.removeAttribute('readonly');
		customerAddressInput.removeAttribute('readonly');
		customerNameInput.focus();
		isEdit = true;
	})
	
	cancel_voucher.addEventListener('click', () => {
	    overlay_voucher.style.display = 'none';
	});
	
	show_Voucher.addEventListener('click', () => {
	    overlay_voucher.style.display = 'flex';
	});
	$('.voucher_get').click(function(){
		let discount = $(this).attr('discount');
		discountValue = discount; // Lưu giá trị giảm giá
		discountCodeInput.value = `- ${discount} VNĐ`;
		discountId = $(this).attr('idPromo');
        overlay_voucher.style.display = 'none';
        let currentTotalCost = billTotalCost.textContent;
        billTotalCost.textContent = parseInt(currentTotalCost) - discount + ' VNĐ';
	})
	
})

function filterProducts() {
   	var input = document.getElementById('search_input');
	var filter = input.value.toLowerCase();
	var vouchers = document.getElementsByClassName('voucher_item');
	console.log(vouchers[0].getAttribute('id'))
	for (var i = 0; i < vouchers.length; i++) {
	    var id = vouchers[i].getAttribute('id').toLowerCase();
	    
	    if (id.indexOf(filter) > -1) {
	         vouchers[i].style.display = '';
	    } else {
	        vouchers[i].style.display = 'none';
	    }
	}
}

