$(document).ready(function(){
	$('.voucher_get').click(function(){
		const voucherId = $(this).attr('id');

        navigator.clipboard.writeText(voucherId)
            .then(() => {
                console.log('Mã ' + voucherId +  ' được sao chép thành công.');
                alert('Mã ' + voucherId +  ' được sao chép thành công.');
            })
            .catch((error) => {
                console.error('Lấy mã thất bại:', error);
                alert('Lấy mã thất bại. Vui lòng thử lại.');
            });
	})
})
	

