prevNextIcon = document.querySelectorAll(".icons span");
currentDate = document.querySelector(".current-date");
const showCalendar = document.getElementById('showCalendar');
const pickStartDate = document.querySelector('.pickStartDate');
const datepicker_showStartDate = document.querySelector('.datepicker_showStartDate');
const pickEndDate = document.querySelector('.pickEndDate');
const daysTag = document.querySelector(".days");
const datepicker_showEndDate = document.querySelector('.datepicker_showEndDate');
let activeDatePicker = null;
let date = new Date(),
	currYear = date.getFullYear(),
	currMonth = date.getMonth();
let selectedDate = date;

let startDate = new Date();
let endDate = new Date();

const months = ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7",
              "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"];

let arrTotalPrice = [];
let mapTotalPrice = new Map();
let mapDateTime = new Map();
let listFilter = [];
var startDay, startMonth, startYear, endDay, endMonth, endYear, startDateFormat, endDateFormat;
const renderCalendar = (currDate, datepicker) => {
    let firstDayofMonth = new Date(currYear, currMonth, 1).getDay(),
    lastDateofMonth = new Date(currYear, currMonth + 1, 0).getDate(),
    lastDayofMonth = new Date(currYear, currMonth, lastDateofMonth).getDay(),
    lastDateofLastMonth = new Date(currYear, currMonth, 0).getDate();
    let liTag = "";

    for (let i = firstDayofMonth; i > 0; i--) {
        liTag += `<li class="inactive">${lastDateofLastMonth - i + 1}</li>`;
    }

    for (let i = 1; i <= lastDateofMonth; i++) {
        let isToday = i === currDate.getDate() && currMonth === currDate.getMonth() 
                     && currYear === currDate.getFullYear() ? "active" : "";
        liTag += `<li class="${isToday}">${i}</li>`;
    }

    for (let i = lastDayofMonth; i < 6; i++) {
        liTag += `<li class="inactive">${i - lastDayofMonth + 1}</li>`
    }
    currentDate.innerText = `${months[currMonth]} ${currYear}`;
    daysTag.innerHTML = liTag;

    daysTag.querySelectorAll('li').forEach(li => {
        li.addEventListener('click', () => {
            daysTag.querySelectorAll('li.active').forEach(activeLi => {
                activeLi.classList.remove('active');
                activeLi.classList.add('normal');
            });

            li.classList.remove('normal');
            li.classList.add('active');

            let selectedDay = parseInt(li.textContent);
            selectedDate = new Date(currYear, currMonth, selectedDay);
            console.log("Ngày đã chọn:", selectedDate);
        
            date = selectedDate;
            if(datepicker === datepicker_showStartDate){
				startDate = selectedDate;
				startDay = startDate.getDate();
				startMonth = startDate.getMonth() + 1;
				startYear = startDate.getFullYear();
				startDateFormat = startYear + "-" + startMonth + "-" + startDay;
			}
            else if(datepicker === datepicker_showEndDate){
				endDate = selectedDate;
				endDay = endDate.getDate();
				endMonth = endDate.getMonth() + 1;
				endYear = endDate.getFullYear();
				endDateFormat = endYear + "-" + endMonth + "-" + endDay;
			}
            	
		    datepicker.textContent = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`;
			currYear = date.getFullYear(),
			currMonth = date.getMonth() + 1;
			currDay = date.getDate();
			dayFormat = currYear + "-" + currMonth + "-" + currDay;

            showCalendar.style.display = 'none';
                    
        });
    });
}

prevNextIcon.forEach(icon => {
    icon.addEventListener("click", () => {
        currMonth = icon.id === "prev" ? currMonth - 1 : currMonth + 1;

        if(currMonth < 0 || currMonth > 11) {
            date = new Date(currYear, currMonth, new Date().getDate());
            currYear = date.getFullYear();
            currMonth = date.getMonth();
        } else {
            date = new Date(currYear, currMonth, '1');
        }
        if(activeDatePicker){
			renderCalendar(date, activeDatePicker);
		}
        
    });
});

pickStartDate.addEventListener('click', () => {
    showCalendar.style.display = 'flex';
    activeDatePicker = datepicker_showStartDate;
    renderCalendar(selectedDate, datepicker_showStartDate);
});

pickEndDate.addEventListener('click', () => {
    showCalendar.style.display = 'flex';
    activeDatePicker = datepicker_showEndDate;
    renderCalendar(selectedDate, datepicker_showEndDate);
});

/////////////////////////////////////////////
var setVoucherDiscount = document.querySelector('.setVoucher_discount');
var setVoucherMinimumPay = document.querySelector('.setVoucher_minOrder');
var setVoucherId = document.querySelector('.setVoucher_ID')

$(document).ready(function(){
	console.log(startDateFormat)
	$('.btnAddVoucher').click(function(){
		let id = setVoucherId.value;
		let discount = setVoucherDiscount.value;
		let minimumPay = setVoucherMinimumPay.value;
		$.ajax({
			method: "POST",
			url: "http://localhost:8080/FastFood/api/promo/add",
			data: {id: id, discount: discount, minimumPay: minimumPay, startDate: startDateFormat, endDate: endDateFormat}
		}).done(function(data){
			alert("Đã thêm voucher thành công!");
		}).fail(function(xhr, status, error){
			alert("Đã xảy ra lỗi: AddVoucher " + error);
			console.error(xhr, status, error);
		})
	})
	
	document.querySelector('.setVoucher_discount').addEventListener('input', function() {
    var discount_num = this.value;
    var errorMessage = document.querySelector('.discountError');

    if (!/^\d+$/.test(discount_num)) {
        if (!errorMessage) {
            errorMessage = document.createElement('p');
            errorMessage.style.position = "absolute";
            errorMessage.style.left = "calc(40% - 15px)";
            errorMessage.style.top = "calc(100% - 10px)";
            errorMessage.style.color = 'red';
            errorMessage.classList.add('discountError');
            errorMessage.textContent = 'Số tiền giảm chỉ chứa các kí tự số.'; 
            this.parentNode.insertBefore(errorMessage, this.nextSibling);
        }
    } else {
        if (errorMessage) {
            errorMessage.remove();
        }
    }
});
document.querySelector('.setVoucher_minOrder').addEventListener('input', function() {
    var minOrder_num = this.value;
    var errorMessage = document.querySelector('.minOrderError');

    if (!/^\d+$/.test(minOrder_num)) {
        if (!errorMessage) {
            errorMessage = document.createElement('p');
            errorMessage.style.position = "absolute";
            errorMessage.style.left = "calc(40% - 15px)";
            errorMessage.style.top = "calc(100% - 10px)";
            errorMessage.style.color = 'red';
            errorMessage.classList.add('minOrderError');
            errorMessage.textContent = 'Số tiền giảm chỉ chứa các kí tự số.'; 
            this.parentNode.insertBefore(errorMessage, this.nextSibling);
        }
    } else {
        if (errorMessage) {
            errorMessage.remove();
        }
    }
});
})