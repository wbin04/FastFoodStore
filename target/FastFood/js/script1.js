function popup({
            ID_prod = '',
            Name_prod = '',
            Desc_prod = '',
            Price_prod = '',
            Img_prod = '',
            Status_prod = ''
        }){
            const main = document.getElementById('popup');
            const hdoverlay = document.querySelector('.header_overlay');
            if(main && hdoverlay){
                hdoverlay.style.display = 'block';
                const popup = document.createElement('label');
                popup.setAttribute('for', 'overlay_on')

                popup.classList.add('overlay');
                popup.innerHTML = `
                    <div id="header" class="overlay"></div>
			            <div class="popup_container">
			                <div class="container">
			                    <div class="container_item container_img">
			                        <div class="image_item">
			                            <img src="${Img_prod}" alt="" style="height: 300px;">
			                        </div>
			                    </div>
			                    <div class="container_item container_detail">
			                        <div class="detail_item container_detail-label">
			                            <div class="popupInfo infoProduct">
			                                <div class="label_item label_name">${Name_prod}</div>
			                                <div class="label_item label_desc">${Desc_prod}</div>
			                                <div class="label_item label_price">${Price_prod} VNĐ</div>
			                            </div>
			                            <div class="popupInfo infoRating">
			                                <a class="popupRating">Xem đánh giá</a>
			                            </div>
			                        </div>
			                        <div class="detail_item container_detail-choice">
			                            <div class="choice_item quantity">
			                                <button class="quantity_item sub_btn">-</button>
			                                <div class="quantity_item num_count">1</div>
			                                <button class="quantity_item add_btn">+</button>
			                            </div>
			                            <button class="choice_item addcart">Thêm vào giỏ hàng</button>
			                        </div>
			                    </div>
			                </div>
			            
		            <div class="prodRating">
		                <div class="rating labelRating">Đánh giá</div>
		                <div class="listRating">
	                        
	                    </div>
		            </div>
		         </div>   
                `;
                
                if(Status_prod === "Tạm hết hàng"){
					popup.querySelector('.sub_btn').style.pointerEvents = 'none';
		            popup.querySelector('.num_count').textContent = '0';
		            popup.querySelector('.add_btn').style.pointerEvents = 'none';
		            popup.querySelector('.addcart').textContent = 'Tạm hết hàng';
		            popup.querySelector('.addcart').style.pointerEvents = 'none';
				}
                
                popup.addEventListener('click', function(event) {
                    if (event.target.classList.contains('overlay')) {
                        popup.remove();
                        hdoverlay.style.display = 'none';
                    }
                });

                const addBtn = popup.querySelector('.add_btn');
                const subBtn = popup.querySelector('.sub_btn');     
                const numCount = popup.querySelector('.num_count');
                const addCartBtn = popup.querySelector('.addcart');
         		const rateClick = popup.querySelector('.popupRating')
                
                addBtn.addEventListener('click', function() {
                    let currentCount = parseInt(numCount.textContent);
                    numCount.textContent = currentCount + 1;
                });

                subBtn.addEventListener('click', function() {
                    let currentCount = parseInt(numCount.textContent);
                    if (currentCount > 1) {
                        numCount.textContent = currentCount - 1;
                    }
                });
                addCartBtn.addEventListener('click', function(e){
				    var foodId = ID_prod;	           
				    var quantity = numCount.textContent;
				    var quantityInt = parseInt(quantity);
				    var totalQuantityDiv = $(".hdcart_numcount")
					var currentTotalQuantity = parseInt(totalQuantityDiv.text())
				    $.ajax({
				        method: "POST",
				        url: "http://localhost:8080/FastFood/api/buy",
				        data: { foodId: foodId,  quantity: quantity }
				    }).done(function(data) {
						totalQuantityDiv.text(currentTotalQuantity + quantityInt) 
				        updateCart();
				        setTimeout(() =>{
		                    popup.remove();
		                    hdoverlay.style.display = 'none';			            
		                }, 300);
		                
				    }).fail(function(xhr, status, error) {
				        window.location.href = "login";
				        console.error(xhr, status, error);
				    });
				});
				
				let containerProd = popup.querySelector('.popup_container');
		
		        const popupRating = popup.querySelector('.popupRating');
		        const prodRating = popup.querySelector('.prodRating');
		        
		        popupRating.addEventListener('click', function(event) {
		            // containerProd.style.transform= 'translateX(-100%)';
		            // rating.style.display = 'block';
		            // rating.style.transform = 'translateX(20%)';    
		            containerProd.style.right = '340px';
		            containerProd.style.left = '340px';
		            prodRating.style.display = 'block';
		            showRatingFood(ID_prod);
		        });
				
                main.appendChild(popup);
            }
        }
        function showRatingFood(foodId){
			$.ajax({
				method: "GET",
				url: "http://localhost:8080/FastFood/api/rating/getRating?foodId=" + foodId, 
		        dataType: "json",
			}).done(function(data){
				
				var listRating = document.querySelector('.listRating');
				listRating.innerHTML = ``;
				console.log(listRating.innerHTML);
				data.forEach(function(item){
					
					var ratingItem = document.createElement('div');
					ratingItem.classList.add('rating_item');
					var ratingHTML = `
						<div class="rating_header">
		                    <div class="rating_username">${item.username}</div>
		                    <div class="rating_numStar">
								${generateStars(item.point)}
							</div>
		                </div>
		                <div class="rating_body">
		                    <textarea readonly class="rating_content" rows="1">${item.content}</textarea>
		                </div>
					`;
					ratingItem.innerHTML = ratingHTML;
					listRating.appendChild(ratingItem);
					console.log(listRating.innerHTML);
				})
			})
		}
		
		function generateStars(rating) {
			let stars = '';
			for(let i = 0; i < 5; i++) {
				if(i < rating) {
					stars += '<i class="fa-solid fa-star average_star"></i>';
				} else {
					stars += '<i class="fa-regular fa-star"></i>';
				}
			}
			return stars;
		}
      
		function updateCart() {
		    $.ajax({
		        method: "GET",
		        url: "http://localhost:8080/FastFood/api/item/updatecart", 
		        dataType: "json",
		    }).done(function(data) {
		       	var cartElement = document.getElementById("cart"); 
			    var cartList = cartElement.querySelector(".listCart");
			
			    // Xóa nội dung cũ của giỏ hàng
			    cartList.innerHTML = '';
		
			    data.forEach(function(item) {
			        var listItem = document.createElement("div");
			        listItem.classList.add("list_item");
			
			        var productHTML = `
			            <div class="prodInCart product_img">
			                <img src="${item.image}" alt="" style="height: 100px; width: auto;">
			            </div>
			            <div class="prodInCart product_detail">
			                <div class="prodInCart_detail prodDetail_label">${item.title}</div>
			                <div class="prodInCart_detail prodDetail_action">
			                    <div class="prodInCart_action prodAct_price">${item.price}</div>
			                    <div class="prodInCart_action prodAct_quantity">
			                        <button class="quantityCart_item subCart_btn" idFood="${item.id}" deli="minus"><</button>
			                        <div class="quantityCart_item numCart_count" quantity="${item.quantity}" price="${item.price}">${item.quantity}</div>
			                        <button class="quantityCart_item addCart_btn" idFood="${item.id}" deli="plus">></button>
			                    </div>
			                </div>
			            </div>
			            <div class="prodInCart_detail product_bin btn-xoa" idFood="${item.id}" quantity="${item.quantity}" price="${item.price}">
			                <i class="fa-solid fa-trash"></i>
			            </div>
			        `;
			        
			        listItem.innerHTML = productHTML;
			
			        
			        cartList.appendChild(listItem);
			    });
			
			    var totalPriceElement = cartElement.querySelector(".total_price");
			    totalPriceElement.textContent = calculateTotalPrice(data) + " VND";
			}).fail(function(xhr, status, error) {
				// alert("Đã xảy ra lỗi: updateCart " + error);
				window.location.href = "login";
				console.error(xhr, status, error);
			});
		}
		function calculateTotalPrice(data) {
		    var totalPrice = 0;
		    data.forEach(function(item) {
		        totalPrice += item.price * item.quantity;
		    });
		    return totalPrice;
		}
		
        function showPopUp(id_product, name_product, desc_product, price_product, img_product, status_product){
            popup({
                ID_prod: id_product,
                Name_prod: name_product,
                Desc_prod: desc_product,
                Price_prod: price_product,
                Img_prod: img_product,
                Status_prod: status_product
            })
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            const cartCloseBtn = document.querySelector('.cart_close');
            cartCloseBtn.addEventListener('click', hideCart);
        });

        function cartVisible() {
            const bodyPage = document.querySelector('.body_page');
            const bodyCart = document.querySelector('.body_cart');

            bodyCart.style.display = 'block';
            bodyPage.style.animation = `bodySlideInLeft ease 0.3s forwards`;
            bodyCart.style.animation = `cartSlideInLeft ease 0.3s forwards`;
        }

        function hideCart() {
            const bodyPage = document.querySelector('.body_page');
            const bodyCart = document.querySelector('.body_cart');

            bodyCart.style.animation = `cartSlideOutRight ease 0.3s forwards`;
            bodyPage.style.animation = `bodySlideOutRight ease 0.3s forwards`;

            setTimeout(() => {
                bodyCart.style.display = 'none';
            }, 300); 
        }

        function showCart() {
            const bodyCart = document.querySelector('.body_cart');

            if (bodyCart.style.display === 'block') {
                hideCart();
            } else {
                cartVisible();
            }
        }
	let deleteItem = document.querySelector('.deleteItem');
	$(document).ready(function(){
		$(document).on('click', '.btn-xoa', function(){
			var button = $(this)
			var foodId = $(this).attr("idFood")
			var row = $(this).closest('.list_item')
			var quanDiv = $(this).closest('.list_item').find('.numCart_count');
			var currentQuantity = parseInt(quanDiv.attr("quantity"))
			console.log(currentQuantity)
			var price = parseInt(button.attr("price"))
			var totalPriceDiv = $(".total_price")
			var currentTotalPrice = parseInt(totalPriceDiv.text().replace(" VND", ""))
			var newTotalPrice = currentTotalPrice - price * currentQuantity
			var totalQuantityDiv = $(".hdcart_numcount")
			var currentTotalQuantity = parseInt(totalQuantityDiv.text())
			
			deleteItem.style.display = 'flex';
			$('.delOpt_yes').off('click').on('click', function(){
	            $.ajax({
	                method: "POST",
	                url: "http://localhost:8080/FastFood/api/item/delete",
	                data: { foodId: foodId}
	            }).done(function(data) {
	                alert("Đã xoá khỏi giỏ hàng thành công");
	                row.remove()
	                totalPriceDiv.text(newTotalPrice + " VND")
	                totalQuantityDiv.text(currentTotalQuantity - currentQuantity)
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
		$(document).on('click', '.subCart_btn', function(){
			var foodId = $(this).attr("idFood")
			var deli = $(this).attr("deli")
			var row = $(this).closest('.list_item')
			var quanDiv = $(this).siblings('.numCart_count')
			var currentQuantity = parseInt(quanDiv.attr("quantity"))
			var newQuantity = currentQuantity - 1
			var price = parseInt(quanDiv.attr("price"))
			var totalPriceDiv = $(".total_price")
			var currentTotalPrice = parseInt(totalPriceDiv.text().replace(" VND", ""))
			var newTotalPrice = currentTotalPrice - price
			var totalQuantityDiv = $(".hdcart_numcount")
			var currentTotalQuantity = parseInt(totalQuantityDiv.text())
			if(currentQuantity > 1){
				$.ajax({
			        method: "POST",
			        url: "http://localhost:8080/FastFood/api/item/changequantity",
			        data: { foodId: foodId, deli: deli}
			    }).done(function(data) {
					
			        quanDiv.text(newQuantity)
			        quanDiv.attr("quantity", newQuantity)	
			        totalPriceDiv.text(newTotalPrice + " VND") 
			        totalQuantityDiv.text(currentTotalQuantity - 1)    
			    }).fail(function(xhr, status, error) {
			        alert("Đã xảy ra lỗi: " + error);
			        console.error(xhr, status, error);
			    });
			}else if(currentQuantity == 1){
				deleteItem.style.display = 'flex';
				$('.delOpt_yes').off('click').on('click', function(){
		            $.ajax({
		                method: "POST",
		                url: "http://localhost:8080/FastFood/api/item/delete",
		                data: { foodId: foodId}
		            }).done(function(data) {
		                alert("Đã xoá khỏi giỏ hàng thành công");
		                row.remove()
		                totalPriceDiv.text(newTotalPrice + " VND")
		                totalQuantityDiv.text(currentTotalQuantity - currentQuantity)
		                deleteItem.style.display = 'none';
		            }).fail(function(xhr, status, error) {
		                alert("Đã xảy ra lỗi: " + error);
		                console.error(xhr, status, error);
		            });
		        });
	
		        $('.delOpt_no').off('click').on('click', function(){
		            deleteItem.style.display = 'none';          
		        });   
			}		    
		})
		
		$(document).on('click', '.addCart_btn', function(){
			var foodId = $(this).attr("idFood")
			var deli = $(this).attr("deli");
			var quanDiv = $(this).siblings('.numCart_count')
			
			var currentQuantity = parseInt(quanDiv.attr("quantity"))
			var newQuantity = currentQuantity + 1
			var price = parseInt(quanDiv.attr("price"))
			var totalPriceDiv = $(".total_price")
			var currentTotalPrice = parseInt(totalPriceDiv.text().replace(" VND", ""))
			var newTotalPrice = currentTotalPrice + price
			
			var totalQuantityDiv = $(".hdcart_numcount")
			var currentTotalQuantity = parseInt(totalQuantityDiv.text())
			    $.ajax({
			        method: "POST",
			        url: "http://localhost:8080/FastFood/api/item/changequantity",
			        data: { foodId: foodId, deli: deli}
			    }).done(function(data) {
			         quanDiv.text(newQuantity)
			         quanDiv.attr("quantity", newQuantity)	
			         totalPriceDiv.text(newTotalPrice + " VND")
			           totalQuantityDiv.text(currentTotalQuantity + 1) 
			    }).fail(function(xhr, status, error) {
			        alert("Đã xảy ra lỗi: " + error);
			        console.error(xhr, status, error);
			    });
		})
		
		$('.search_icon').click(function(){
			var text = $('.search_text').val();
			console.log(text);
			Redirect(text);
		})
		
		/*$('.hdlogout').click(function(){
			$.ajax({
				method: "GET",
				url: "http://localhost:8080/FastFood/logout"
			}).done(function(data){
				alert("Dang xuat thanh cong");
			}).fail(function(xhr, status, error) {
			     alert("Đã xảy ra lỗi: " + error);
			     console.error(xhr, status, error);
			})
		})*/
	})
	function Redirect(key){
		window.location = "http://localhost:8080/FastFood/menu?key=" + key;
	}
	function checkCartSize(){
		let emptyCart = document.querySelector('.emptyCart');
		var cartSize = parseInt($(".hdcart_numcount").text());
		if(cartSize == 0){
			emptyCart.style.display = 'flex';
		}else if(cartSize > 0){
			emptyCart.style.display = 'none';
		}
	}
document.addEventListener('DOMContentLoaded', function() {
    const iconUser = document.querySelector('.icon_user');
    const hdAccount = iconUser.querySelector('.hdaccount');
    
    let timeoutId;

    /*iconUser.addEventListener('mouseover', function() {
        clearTimeout(timeoutId);
        hdAccount.style.display = 'flex';
    });*/

    /*iconUser.addEventListener('mouseleave', function() {
        timeoutId = setTimeout(function() {
            hdAccount.style.display = 'none';
        }, 1500);
    });*/
});

function showCartEmpty(){
	const cartSize = parseInt((document.querySelector('.hdcart_numcount')).textContent)
	if(cartSize == 0)
		alert("Giỏ hàng của bạn đang trống");
	else
		window.location.href = "checkout";
}
	
document.addEventListener("DOMContentLoaded", function() {
	if (sessionStorage.getItem("scrollToFooter") === "true") {
        document.getElementById("footer").scrollIntoView({ behavior: "smooth" });
        sessionStorage.removeItem("scrollToFooter");
    }
    document.getElementById("scrollTo").addEventListener("click", function(event) {
        event.preventDefault();
        document.getElementById("footer").scrollIntoView({ behavior: "smooth" });
    });
});