$(document).ready(function(){
	$('.optAdd').click(function(){
		var imgInput = document.querySelector('.img_addProd')
		var titleInput = document.querySelector('.setAddProdName')
		var descInput = document.querySelector('.setAddProdDesc')
		var priceInput = document.querySelector('.setAddProdPrice')
		var cateInput = document.querySelector('.setAddProdType')
		
		var title = titleInput.value;
		var desc = descInput.value;
		var price = priceInput.value;
		var cate = cateInput.selectedIndex + 1;
		var img = imgInput.getAttribute('src');
		console.log(title); console.log(desc); console.log(price); console.log(cate); console.log(img);
		$.ajax({
			method: "POST",
			url: "http://localhost:8080/FastFood/api/food/add",
			data: { title: title, desc: desc, price: price, cate: cate, img: img}
		}).done(function(data) {
			    alert("Đã thêm món ăn thành công");
			    window.location.href = "http://localhost:8080/FastFood/adminManageFood";
		}).fail(function(xhr, status, error) {
			    alert("Đã xảy ra lỗi: " + error);
			    console.error(xhr, status, error);
		});	
	})
	
})


const addImageBtn = document.querySelector('.addImage');
const imgAddProd = document.querySelector('.img_addProd');
const setAddProdImage = document.querySelector('.setAddProdImage');
let imageData;


$(document).ready(function(){
	/*$('.addImage').on('click', function(){
		var formData = new FormData();
		var photoInput = document.getElementById('photo');
		var photoInput = document.querySelector('input[type="file"]');
		var file = photoInput.files[0];
		if (file) {
		    formData.append('photo', file);
		} else {
		    console.log("Không có tệp nào được chọn.");
		}
		formData.append('photo', photoInput.files[0]);
		$.ajax({
			type: 'POST',
			url: "http://localhost:8080/FastFood/uploadImage",
			data: formData,
			processData: false,
			contentType: false,
		}).done(function(data){
			alert("Đã thêm ảnh thành công");
			setAddProdImage.style.display = 'block';
			var imageURL = data;
			var imageShow = $('#img_addProdShow');
			imageShow.attr('src', imageURL);
		}).fail(function(xhr, status, error) {
		    alert("Đã xảy ra lỗi: " + error);
		    console.error(xhr, status, error);
		});	
	})*/
	document.querySelector('.setAddProdPrice').addEventListener('input', function() {
	    var setAddProdPrice_num = this.value;
	    var errorMessage = document.querySelector('.setAddProdPriceError');
	
	    if (!/^\d+$/.test(setAddProdPrice_num)) {
	        if (!errorMessage) {
	            errorMessage = document.createElement('p');
	            errorMessage.style.position = "absolute";
	            errorMessage.style.left = "calc(40% - 15px)";
	            errorMessage.style.top = "calc(100% - 10px)";
	            errorMessage.style.color = 'red';
	            errorMessage.classList.add('setAddProdPriceError');
	            errorMessage.textContent = 'Giá sản phẩm chỉ chứa các kí tự số.'; 
	            this.parentNode.insertBefore(errorMessage, this.nextSibling);
	        }
	    } else {
	        if (errorMessage) {
	            errorMessage.remove();
	        }
	    }
	});
	
	
	document.getElementById('photoInput').addEventListener('change', function(event) {
	    var file = event.target.files[0];
	    if (file) {
	        var formData = new FormData();
	        formData.append('photo', file);
	        $.ajax({
	            type: 'POST',
	            url: 'http://localhost:8080/FastFood/uploadImage',
	            data: formData,
	            processData: false,
	            contentType: false,
	        }).done(function(data){
				/*alert("Đã thêm ảnh thành công");*/
				setAddProdImage.style.display = 'flex';
				var imageURL = data;
				var imageShow = $('#img_addProdShow');
				imageShow.attr('src', imageURL);
			}).fail(function(xhr, status, error) {
			    alert("Đã xảy ra lỗi: " + error);
			    console.error(xhr, status, error);
			});	
	    }
	    else{
			console.log("Không có tệp nào được chọn!");
		}
	});
		
})

/*addImageBtn.addEventListener('click', () => {    
    const fileInput = document.createElement('input');
    fileInput.type = 'file';
    fileInput.accept = 'image';

    fileInput.addEventListener('change', (event) => {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                imageData = e.target.result;
                const fileName =file.name;
                imgAddProd.src = './assets/' + fileName; 
                setAddProdImage.style.display = 'block';
                addImageBtn.textContent = 'Thay đổi hình ảnh';
            };
            reader.readAsDataURL(file);
        }
    });

    fileInput.click();
});*/