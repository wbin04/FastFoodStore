
const optEditLink = document.querySelector('.optEdit');
const optSaveBtn = document.querySelector('.optSave');
const optDel = document.querySelector('.optDel');
const productIDInput = document.querySelector('.setProdID');
const productNameInput = document.querySelector('.setProdName');
const productDescInput = document.querySelector('.setProdDesc');
const productPriceInput = document.querySelector('.setProdPrice');
const productImageInput = document.querySelector('.img_detailProd');
//const productChangeImage = document.querySelector('.changeImage');
const productTypeInput = document.querySelector('.setProdType');
const formGroup = document.querySelector('.form-group');

optEditLink.addEventListener('click', function(event) {
    // productIDInput.removeAttribute('readonly');
    productNameInput.removeAttribute('readonly');
    productDescInput.removeAttribute('readonly');
    productPriceInput.removeAttribute('readonly');
    productTypeInput.removeAttribute('disabled');

    productNameInput.focus();

    formGroup.style.display = 'block';
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
				/*setProdImage.style.display = 'flex';*/
				var imageURL = data;
				var imageShow = $('#img_detailProdShow');
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

    optSaveBtn.style.display = 'block';
    optDel.style.display = 'none';
});

optSaveBtn.addEventListener('click', function(event) {
    // productIDInput.setAttribute('readonly', true);
    const confirmUpdate = document.querySelector('.confirmUpdate_product');
    confirmUpdate.style.display = 'flex';


    $('.confirmOptEdit_yes').off('click').on('click', function(){
		productNameInput.setAttribute('readonly', true);
    	productDescInput.setAttribute('readonly', true);
    	productPriceInput.setAttribute('readonly', true);
    	productTypeInput.setAttribute('disabled', '');
        
        var foodId = productIDInput.value
        var title = productNameInput.value
        var desc = productDescInput.value
        var price= productPriceInput.value
        var image = productImageInput.src
        var cate = productTypeInput.selectedIndex + 1;
      
        $.ajax({
			method: "POST",
	        url: "http://localhost:8080/FastFood/api/food/update",
	        data: { foodId: foodId,  title: title, desc: desc, price: price, image: image, cate: cate }
	    }).done(function(data) {
	        alert("Đã cập nhật món ăn thành công");
	 	}).fail(function(xhr, status, error) {
	        alert("Đã xảy ra lỗi: " + error);
	        console.error(xhr, status, error);
	    });
		confirmUpdate.style.display = 'none';
        optSaveBtn.style.display = 'none';
        optDel.style.display = 'block';
        formGroup.style.display = 'none';
	});

     $('.confirmOptEdit_no').off('click').on('click', function(){
		 confirmUpdate.style.display = 'none';
	 })
});

optDel.addEventListener('click', () => {
    const confirmDelete = document.querySelector('.confirmDelete_product');
    confirmDelete.style.display = 'flex';


    $('.confirmOptDel_yes').off('click').on('click', function(){
        const foodId = productIDInput.value;
        $.ajax({
			method: "POST",
	        url: "http://localhost:8080/FastFood/api/food/delete",
	        data: { foodId: foodId}
	    }).done(function(data) {
	        alert("Đã xoá món ăn thành công");
	        window.location.href = "http://localhost:8080/FastFood/adminManageFood";
	 	}).fail(function(xhr, status, error) {
	        alert("Đã xảy ra lỗi: " + error);
	        console.error(xhr, status, error);
	    });
        confirmDelete.style.display = 'none';
    });

    $('.confirmOptDel_no').off('click').on('click', function(){
        confirmDelete.style.display = 'none';
    });
});

	document.querySelector('.setProdPrice').addEventListener('input', function() {
	    var setProdPrice_num = this.value;
	    var errorMessage = document.querySelector('.setProdPriceError');
	
	    if (!/^\d+$/.test(setProdPrice_num)) {
	        if (!errorMessage) {
	            errorMessage = document.createElement('p');
	            errorMessage.style.position = "absolute";
	            errorMessage.style.left = "calc(40% - 15px)";
	            errorMessage.style.top = "calc(100% - 10px)";
	            errorMessage.style.color = 'red';
	            errorMessage.classList.add('setProdPriceError');
	            errorMessage.textContent = 'Giá sản phẩm chỉ chứa các kí tự số.'; 
	            this.parentNode.insertBefore(errorMessage, this.nextSibling);
	        }
	    } else {
	        if (errorMessage) {
	            errorMessage.remove();
	        }
	    }
	});
	
