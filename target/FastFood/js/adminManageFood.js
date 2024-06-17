$(document).ready(function(){
	$('.btn-xoa').click(function(){
		var foodId = $(this).attr("idFood");
		var row = $(this).closest('.productItem')
		const deleteItem = document.querySelector('.deleteItem')
		deleteItem.style.display = 'flex';
		$('.delOpt_yes').off('click').on('click', function(){
            $.ajax({
		        method: "POST",
		        url: "http://localhost:8080/FastFood/api/food/delete",
		        data: { foodId: foodId}
		    }).done(function(data) {
		        alert("Đã xoá món ăn thành công");
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
	$(document).on('change', '.status', function() {
	    var foodId = $(this).attr('foodId');
	    var status = $(this).val();
	    $.ajax({
	        method: "POST",
	        url: "http://localhost:8080/FastFood/api/food/updateAvailability",
	        data: { foodId: foodId, availability: status }
	    }).done(function(data) {
	        alert('Update food availability ok');
	    }).fail(function(xhr, status, error) {
	        alert("Đã xảy ra lỗi: " + error);
	        console.error(xhr, status, error);
	    });
	});
	$('.search_icon').click(function(){
		var text = $('.search_text').val();
		console.log(text);
		window.location = "http://localhost:8080/FastFood/adminManageFood?key=" + text;
	})
})

