const confirmCancel = document.querySelector('.confirmCancel');
const confirmCancelSuccess = document.querySelector('.confirmCancelSuccess');
const orderStatus = document.querySelector('.orderStatus')
const optEdit = document.querySelector('.optEdit');
const optCancel = document.querySelector('.optCancel');
const optRate = document.querySelector('.optRate');
const checkBoxRate = document.querySelectorAll('.selectedProduct')
switch(orderStatus.textContent){
    case 'Chờ xác nhận':
        orderStatus.style.color = '#FFD500'
        /*optEdit.style.display = 'block';*/
        optCancel.style.display = 'block';
        optRate.style.display = 'none';
        checkBoxRate.forEach(function(checkBox){
			checkBox.style.display = 'none';
		})
        
        break;
    case 'Đang vận chuyển':
        orderStatus.style.color = '#FF971C'
        optRate.style.display = 'none';
        /*console.log(optRate)
        optEdit.style.display = 'none';*/
        optCancel.style.display = 'none';
        checkBoxRate.forEach(function(checkBox){
			checkBox.style.display = 'none';
		})
        break;
    case 'Đã hoàn thành':
        orderStatus.style.color = '#72CB3B'
        /*optEdit.style.display = 'none';*/
        optCancel.style.display = 'none';
        optRate.style.display = 'block';
        break;
    case 'Đã huỷ':
        orderStatus.style.color = '#FF3213'
        /*optEdit.style.display = 'none';*/
        optCancel.style.display = 'none';
        optRate.style.display = 'none';
        checkBoxRate.forEach(function(checkBox){
			checkBox.style.display = 'none';
		})
        break;
    default: break;
}

console.log(orderStatus.textContent)

$(document).ready(function(){
	$(document).on('click', '.optCancel', function(){
		var status = "Đã huỷ"
		var orderId = $(this).attr("orderId")
		var currentStatusDiv = $(".orderStatus");
		confirmCancel.style.display = 'flex';
		console.log(orderId)
		$('.confirmOpt_yesCancel').on('click', function(){
			var note = document.querySelector('.noteReason').value;
			$.ajax({
				method: "POST",
		        url: "http://localhost:8080/FastFood/api/order/changeStatus",
		        data: { status: status, orderId: orderId, note: note}
			  }).done(function(data) {
			        confirmCancelSuccess.style.display = 'flex';
    				confirmCancel.style.display = 'none';
			        currentStatusDiv.text(status);
			       	orderStatus.style.color = '#FF3213'			
			        /*optEdit.style.display = 'none';*/
		            optCancel.style.display = 'none';
		            optRate.style.display = 'none';
			        
			  }).fail(function(xhr, status, error) {
			        alert("Đã xảy ra lỗi: " + error);
			        console.error(xhr, status, error);
			  })
		});
	})
})
const addRating = document.querySelector('.addRating')
const addRatingSuccess = document.querySelector('.addRatingSuccess')
$(document).ready(function() {

	var checkboxes = document.querySelectorAll('.selectedProduct');
	
	var checkBoxProd;
    checkboxes.forEach(function(checkbox) {
        checkbox.addEventListener('click', function() {
            if (this.checked) {
                this.setAttribute('checked', 'checked');
                checkBoxProd = document.querySelectorAll('.selectedProduct:checked');
                console.log(checkBoxProd);
            } else {
                this.removeAttribute('checked');
            }
        });
    });
	$('.optRate').click(function(event) {
		event.preventDefault();
	
		var selectedProducts = document.querySelectorAll('.selectedProduct:checked');
		var form = document.getElementById('ratingForm');
		var oldInputs = form.querySelectorAll('input[name="selectedProducts[]"]');
		oldInputs.forEach(function(input) {
			input.remove();
		});
		selectedProducts.forEach(function(checkbox) {
			var input = document.createElement('input');
			input.type = 'hidden';
			input.name = 'selectedProducts[]';
			input.value = checkbox.value;
			form.appendChild(input);
			
		});
		addRating.style.display = 'flex';
	});
	
	$('.confirmOpt_no').click(function(event) {
		event.preventDefault();
		addRating.style.display = 'none';
	});

	$('.confirmOpt_ok').click(function(event) {
		event.preventDefault();
		addRatingSuccess.style.display = 'none';
	});
	$('.confirmOpt_yes').click(function(event) {
        event.preventDefault();
        var orderId = $(this).attr('orderId')
     	//form này có nhiều thông tin
        $.ajax({
            type: 'POST',
            url: 'ratingf',
            data: $('form').serialize() + '&orderId=' + orderId,
            success: function(response) {
                checkBoxProd.forEach(function(checkbox) {
                    checkbox.disabled = true;
                });
               if(checkIfAllCheckBoxDis()){
				   optRate.style.display = 'none';
			   }
            }
        });
        addRating.style.display = 'none';
        addRatingSuccess.style.display = 'flex';
    });
});

function checkIfAllCheckBoxDis(){
	var checkboxs = document.querySelectorAll('.selectedProduct');
	var allDisabled = true;
	checkboxs.forEach(function(checkBox){
		if(!checkBox.disabled){
			allDisabled = false;
			return allDisabled;
		}
	})
	return true;
}

const fillOrderDetail = (status) => {  // moithem
    switch(orderStatus.textContent){
        case 'Chờ xác nhận':
            optEdit.style.display = 'block';
            optCancel.style.display = 'block';
            optRate.style.display = 'none';
            break;
        case 'Đang vận chuyển':
            optEdit.style.display = 'none';
            optCancel.style.display = 'none';
            optRate.style.display = 'none';
            break;
        case 'Đã hoàn thành':
            optEdit.style.display = 'none';
            optCancel.style.display = 'none';
            optRate.style.display = 'block';
            break;
        case 'Đã huỷ':
            optEdit.style.display = 'none';
            optCancel.style.display = 'none';
            optRate.style.display = 'none';
            break;
        default: break;
    }
}


const confirmOpt_noCancel = document.querySelector('.confirmOpt_noCancel');
confirmOpt_noCancel.addEventListener('click', () => {
    confirmCancel.style.display = 'none';
});

const confirmOpt_okCancel = document.querySelector('.confirmOpt_okCancel');
confirmOpt_okCancel.addEventListener('click', () => {
    confirmCancelSuccess.style.display = 'none';
});

document.addEventListener('DOMContentLoaded', function() {
    const iconUser = document.querySelector('.icon_user');
    const hdAccount = iconUser.querySelector('.hdaccount');
    
    let timeoutId;

   /* iconUser.addEventListener('mouseover', function() {
        clearTimeout(timeoutId);
        hdAccount.style.display = 'flex';
    });
*/
    /*iconUser.addEventListener('mouseleave', function() {
        timeoutId = setTimeout(function() {
            hdAccount.style.display = 'none';
        }, 1500);
    });*/
});


