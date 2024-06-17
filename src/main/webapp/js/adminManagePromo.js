const discountForm = document.querySelector('.managerDiscount_form')
const updateVoucherForm = document.querySelector('.managerUpdateVoucher_form');
$(document).ready(function(){
	$('.btn-xoa').click(function(){
		var promoId = $(this).attr("idPromo");
		var row = $(this).closest('.voucherItem')
		const deleteItem = document.querySelector('.deleteItem')
		deleteItem.style.display = 'flex';
		$('.delOpt_yes').off('click').on('click', function(){
            $.ajax({
		        method: "POST",
		        url: "http://localhost:8080/FastFood/api/promo/delete",
		        data: { promoId: promoId}
		    }).done(function(data) {
		        alert("Đã xoá voucher thành công");
		        row.remove()
		        deleteItem.style.display = 'none';
		    }).fail(function(xhr, status, error) {
		        alert("Đã xảy ra lỗi: " + error);
		        console.error(xhr, status, error);
		    });
        });

        $('.delOpt_no').off('click').on('click', function(){
            deleteItem.style.display = 'none';          
        });
		
	})
})

