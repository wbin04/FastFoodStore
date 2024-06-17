const managerCount = document.querySelector('.manager_count');
const managerCountingForm = document.querySelector('.managerCounting_form');
const showCalendar = document.getElementById('showCalendar');
const managerOrderType = document.getElementById('.')
const daysTag = document.querySelector(".days"),
currentDate = document.querySelector(".current-date"),
prevNextIcon = document.querySelectorAll(".icons span");
let dateFilterOpt = document.querySelector('.datefilter_option');


let date = new Date(),
	currYear = date.getFullYear(),
	currMonth = date.getMonth();
let selectedDate = date;

const months = ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7",
              "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"];

let arrTotalPrice = [];
let mapTotalPrice = new Map();
let listFilter = [];
const renderCalendar = (currDate) => {
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
			addCountToHTML(selectedDate);
			/*            
			currYear = date.getFullYear(),
			currMonth = date.getMonth() + 1;
			currDay = date.getDate();
			dayFormat = currYear + "-" + currMonth + "-" + currDay;*/
            /*$.ajax({
				method: "GET",
				url: "http://localhost:8080/FastFood/api/order/getOrder", 
				dataType: "json",
				data: { date: dayFormat}
			}).done(function(data) {
			   	mapDateTime = new Map();
			   	
			 	const datepicker_showDate = managerCountingForm.querySelector('.datepicker_showDate');
			    datepicker_showDate.textContent = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`;
			
			    const ctx = document.getElementById('counting_chart').getContext('2d');
			    const existingChart = Chart.getChart(ctx);
			    if (existingChart) {
			        existingChart.destroy();
			    }
			    arrTotalPrice = [];
			    arrDateTime = [];
				
			    for (let i = 6; i >=0; i--) {
			        const dateToProcess = new Date(date); //currentDatetime
			        dateToProcess.setDate(date.getDate() - i); //currentDatetime
			        
			        const day = dateToProcess.getDate();
			        const month = dateToProcess.getMonth() + 1;
			        const year = dateToProcess.getFullYear();
			
			        const formattedDate = `${day}/${month}/${year}`;
			        arrDateTime.push(formattedDate);
			        const month1 = (dateToProcess.getMonth() + 1).toString().padStart(2, '0');
			         const day1 = (dateToProcess.getDate()).toString().padStart(2, '0');
			        const DateSql = year + "-" + month1 + "-" +day1;
					mapDateTime.set(DateSql, 0);
			    }
			    for(let key in data){
					if(data.hasOwnProperty(key)){
						let value = data[key];
						mapDateTime.set(key, value);
					}	   
				}
			 
			    drawChartDate(arrDateTime, mapDateTime, 'day');
			}).fail(function(xhr, status, error) {
				alert("Đã xảy ra lỗi: getOrder " + error);
				console.error(xhr, status, error);
			});
            
             $.ajax({
				method: "GET",
				url: "http://localhost:8080/FastFood/api/order/filter", 
				dataType: "json",
				data: { date: dayFormat}
			}).done(function(data) {
			   	listFilter = data;
			   	const filterProdQuantity = $(".setProdQuantity")
			    const filterUserQuantity = $(".setUserQuantity");
			    const filterOrderQuantity = $(".setOrderQuantity");
			    const filterTotalPrice = $(".setTotalPrice");
			    
			    filterProdQuantity.text(listFilter[0])
			    filterUserQuantity.text(listFilter[1])
			    filterOrderQuantity.text(listFilter[2])
			    filterTotalPrice.text(listFilter[3])
			}).fail(function(xhr, status, error) {
				alert("Đã xảy ra lỗi: getOrder " + error);
				console.error(xhr, status, error);
			});
            */
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
        console.log(date);
        renderCalendar(date);
    });
});


let arrProdQuantity = [];
let arrUserQuantity = [];
let arrOrderQuantity = [];
let arrDateTime = [];


let listOrder = [];
let listOrderDetail = [];


const addCountToHTML = (date) => {
	currYear = date.getFullYear(),
	currMonth = date.getMonth() + 1;
	currDay = date.getDate();
	dayFormat = currYear + "-" + currMonth + "-" + currDay;
    $.ajax({
		method: "GET",
		url: "http://localhost:8080/FastFood/api/order/getOrder", 
		dataType: "json",
		data: { date: dayFormat}
	}).done(function(data) {
	   	let mapDateTime = new Map();
	   	
	 	const datepicker_showDate = managerCountingForm.querySelector('.datepicker_showDate');
	    datepicker_showDate.textContent = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`;
	
	    const ctx = document.getElementById('counting_chart').getContext('2d');
	    const existingChart = Chart.getChart(ctx);
	    if (existingChart) {
	        existingChart.destroy();
	    }
	    arrTotalPrice = [];
	    arrDateTime = [];
		
	    for (let i = 6; i >=0; i--) {
	        const dateToProcess = new Date(date); //currentDatetime
	        dateToProcess.setDate(date.getDate() - i); //currentDatetime
	        
	        const day = dateToProcess.getDate();
	        const month = dateToProcess.getMonth() + 1;
	        const year = dateToProcess.getFullYear();
	
	        const formattedDate = `${day}/${month}/${year}`;
	        arrDateTime.push(formattedDate);
	        const month1 = (dateToProcess.getMonth() + 1).toString().padStart(2, '0');
	        const day1 = (dateToProcess.getDate()).toString().padStart(2, '0');
	        const DateSql = year + "-" + month1 + "-" +day1;
			mapDateTime.set(DateSql, 0);
			
	    }
	    for(let key in data){
			if(data.hasOwnProperty(key)){
				let value = data[key];
				mapDateTime.set(key, value);
			}	   
		}
		dateFilterOpt.value = 'day';
		
	    drawChartDate(arrDateTime, mapDateTime, 'day');
	}).fail(function(xhr, status, error) {
		alert("Đã xảy ra lỗi: getOrder " + error);
		console.error(xhr, status, error);
	});
    
     $.ajax({
		method: "GET",
		url: "http://localhost:8080/FastFood/api/order/filter", 
		dataType: "json",
		data: { date: dayFormat}
	}).done(function(data) {
	   	listFilter = data;
	   	const filterProdQuantity = $(".setProdQuantity")
	    const filterUserQuantity = $(".setUserQuantity");
	    const filterOrderQuantity = $(".setOrderQuantity");
	    const filterTotalPrice = $(".setTotalPrice");
	    
	    filterProdQuantity.text(listFilter[0])
	    filterUserQuantity.text(listFilter[1])
	    filterOrderQuantity.text(listFilter[2])
	    filterTotalPrice.text(listFilter[3])
	}).fail(function(xhr, status, error) {
		alert("Đã xảy ra lỗi: getOrder " + error);
		console.error(xhr, status, error);
	});
}

function setManagerCounting() {
    managerCount.style.backgroundColor = '#f9e1cc';
    managerCountingForm.style.display = 'flex';
    const currentDatetime = new Date();
    addCountToHTML(currentDatetime);
}
setManagerCounting();

function drawChart(typeDate, para) {
    const labels = typeDate;
    const data = {
        labels: labels,
        datasets: [{
            label: 'Doanh thu trong ngày',
            backgroundColor: '#ff7d01',
            borderColor: '#ff7d01',
            data: Array.from(para.values()),
            fill: false
        }]
    };

    const config = {
        type: 'line',
        data: data,
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: 'Biểu đồ doanh thu theo ngày trong 7 ngày qua'
                }
            },
            scales: {
                x: {
                    display: true,
                    title: {
                        display: true,
                        text: 'Ngày'
                    }
                },
                y: {
                    display: true,
                    title: {
                        display: true,
                        text: 'Doanh thu (VNĐ)'
                    }
                }
            }
        }
    };

    const ctx = document.getElementById('counting_chart').getContext('2d');
    const myLineChart = new Chart(ctx, config);
}

const pickDate = document.querySelector('.pickDate');

pickDate.addEventListener('click', () => {
    showCalendar.style.display = 'flex';
    renderCalendar(selectedDate);
});


///////////////////////////////////////////////////////////////////////////////

function calculateTypeProduct() {
    let arrTypeProduct = [];

    listProduct.forEach(product => {
        const id = product.id;
        const type = product.type;
        const price = product.price;

        const existingType = arrTypeProduct.find(item => item.type === type);

        if (!existingType) {
            arrTypeProduct.push({
                id: id,
                type: type,
                price: price
            });
        }
    });

    // console.log(arrTypeProduct);

    return arrTypeProduct;
}

let arrCurrentWeek = [],
	arrLastWeek = [],
	arrCurrentYear = [],
	arrLastYear = [];

function getCurrentWeek() {
    return $.ajax({
        method: "GET",
        url: "http://localhost:8080/FastFood/api/order/getCurrentWeek",
        dataType: "json",
    });
}

function getLastWeek() {
    return $.ajax({
        method: "GET",
        url: "http://localhost:8080/FastFood/api/order/getLastWeek",
        dataType: "json",
    });
}

function getCurrentYear() {
    return $.ajax({
        method: "GET",
        url: "http://localhost:8080/FastFood/api/order/getCurrentYear",
        dataType: "json",
    });
}

function getLastYear() {
    return $.ajax({
        method: "GET",
        url: "http://localhost:8080/FastFood/api/order/getLastYear",
        dataType: "json",
    });
}

function getCate(){
	return $.ajax({
		method: "GET",
        url: "http://localhost:8080/FastFood/api/category/getCatename",
        dataType: "json",
	});
}

function getCateRevenue(){
	return $.ajax({
		method: "GET",
        url: "http://localhost:8080/FastFood/api/category/getRevenue",
        dataType: "json",
	})
}

function showChart(period) {
    const selectedValue = period.value;
    console.log("Selected period:", selectedValue);

    switch (selectedValue) {
        case 'day':
            addCountToHTML(selectedDate);
            break;
        case 'week':
            Promise.all([getCurrentWeek(), getLastWeek()]).then((results) => {
                const [currentWeekData, lastWeekData] = results;
                console.log("Drawing week chart with data:", lastWeekData, currentWeekData);
                drawChartWeek(lastWeekData, currentWeekData);
            }).catch(error => {
                console.error("Error in fetching week data:", error);
            });
            break;
        /*case 'month':
            Promise.all([getCate(), getCateRevenue()]).then((results) => {
                const [CateName, CateRevenue] = results;
                console.log("Drawing week chart with data:", CateName, CateRevenue);
                drawChartMonth(CateName, CateRevenue);
            }).catch(error => {
                console.error("Error in fetching week data:", error);
            });
            break;*/
        case 'year':
            Promise.all([getCurrentYear(), getLastYear()]).then((results) => {
                const [currentYearData, lastYearData] = results;
                console.log("Drawing year chart with data:", lastYearData, currentYearData);
                drawChartYear(lastYearData, currentYearData);
            }).catch(error => {
                console.error("Error in fetching year data:", error);
            });
            break;
        default:
            break;
    }
}

function drawChartDate(typeDate, para, chartType) {
    const typeLabels = {
        day: 'Doanh thu trong ngày',
        week: 'Doanh thu trong tuần',
        month: 'Doanh thu trong tháng',
        year: 'Doanh thu trong năm'
    }
    const typeTexts = {
        day: 'Biểu đồ thể hiện doanh thu theo ngày trong 7 ngày qua',
        week: 'Biểu đồ thể hiện doanh thu theo tuần trong 4 tuần qua',
        month: 'Biểu đồ thể hiện doanh thu theo tháng trong 12 tháng qua',
        year: 'Biểu đồ thể hiện doanh thu theo năm trong 5 năm qua'
    }
    const typeLabel = typeLabels[chartType];
    const typeText = typeTexts[chartType];

    const labels = typeDate;
    const data = {
        labels: labels,
     
        datasets: [{
            label: typeLabel,
            backgroundColor: '#d64e12',
            borderColor: '#d64e12',
            data: Array.from(para.values()),
            fill: false,
            pointStyle: 'circle',
            pointRadius: 5,
            pointHoverRadius: 10,
            pointHoverBackgroundColor: '#60dbe8'
        }]
    };

    const config = {
        type: 'line',
        data: data,
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: typeText
                },
                tooltip: {
                    callbacks: {
                        label: function(tooltipItem) {
                            return 'Doanh thu: ' + tooltipItem.raw + ' VNĐ';
                        }
                    }
                }
            },
            scales: {
                x: {
                    display: true,
                    title: {
                        display: true,
                        text: 'Ngày'
                    }
                },
                y: {
                    display: true,
                    title: {
                        display: true,
                        text: 'Doanh thu (VNĐ)'
                    },
                    beginAtZero: true
                }
            }
        }
    };

    const ctx = document.getElementById('counting_chart').getContext('2d');
    const existingChart = Chart.getChart(ctx);
    if (existingChart) {
        existingChart.destroy();
    }
    const myLineChart = new Chart(ctx, config);
}

// //////////////////////////////////////////////////////////////////////////////////////////////////////


function drawChartWeek(lastData, thisData) {
    const weekLabel =['Chủ Nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy'];
	console.log(lastData);
	console.log(thisData);
    const ctx = document.getElementById('counting_chart').getContext('2d');

    const existingChart = Chart.getChart(ctx);
    if (existingChart) {
        existingChart.destroy();
    }

    const config = {
        type: 'bar',
        data: {
            labels: weekLabel,
            datasets: [
                {
                    label: 'Tuần Trước',
                    data: lastData,
                    backgroundColor: '#60dbe8',
                    barPercentage: 1,
                    categoryPercentage: 0.5
                },
                {
                    label: 'Tuần Này',
                    data: thisData,
                    backgroundColor: '#d64e12',
                    barPercentage: 1,
                    categoryPercentage: 0.5
                }
            ]
        },
        options: {
            indexAxis: 'x',
            responsive: true,
            scales: {
                x: {
                    stacked: false,
                    display: true,
                    title: {
                        display: true,
                        text: 'Ngày trong tuần'
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Doanh thu (VNĐ)'
                    }
                }
            },
            plugins: {
                legend: {
                    position: 'top'
                },
                title: {
                    display: true,
                    text: 'Biểu đồ thể hiện doanh thu theo ngày của tuần này và tuần trước'
                },
                tooltip: {
                    callbacks: {
                        label: function(tooltipItem) {
                            return 'Doanh thu: ' + tooltipItem.raw + ' VNĐ';
                        }
                    }
                }
            }
            
        }
    };

    const chart = new Chart(ctx, config);
}

// //////////////////////////////////////////////////////////////////////////////////////////////////////


function drawChartMonth(arrType, thisData) {
    const ctx = document.getElementById('counting_typeChart').getContext('2d');
	console.log(arrType);
	console.log(thisData);
    const existingChart = Chart.getChart(ctx);
    if (existingChart) {
        existingChart.destroy();
    }

    const config = {
        type: 'pie',
        data: {
            labels: arrType,
            datasets: [
                {
                    label: "Doanh thu:",
                    data: thisData,
                    backgroundColor: [
                        '#d64e12',
                        '#f9a52c',
                        '#efdf48',
                        '#8bd346',
                        '#60dbe8',
                        '#16a4d8',
                        '#9b5fe0'
                    ],
                    barPercentage: 1,
                    categoryPercentage: 0.5
                }
            ]
        }
        ,
        options: {
            layout: {
                padding: {
                    // left: 20,
                    // right: 20,
                    // top: 20,
                    // bottom: 20
                    right: 150
                }
            },
            plugins: {
                legend: {
                    position: 'right'
                },
                title: {
                    display: true,
                    text: 'Biểu đồ thể hiện doanh thu theo từng loại món ăn trong tháng',
                    padding: 20
                },
                tooltip: {
                    callbacks: {
                        label: function(tooltipItem) {
                            return 'Doanh thu: ' + tooltipItem.raw + ' VNĐ';
                        }
                    }
                }
            },
            /*scales: {
                r: {
                    // pointLabels: {
                    //     display: false // Ẩn các chỉ số trên trục r
                    // },
                    ticks: {
                        display: false // Ẩn các đường gốc trục r
                    }
                }
            }*/
        }
    };

    const chart = new Chart(ctx, config);
}

// /////////////////////////////////////////////////////////////////////////////////////////////////////

function drawChartYear(lastData, thisData) {
    const monthsLabel = ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7",
              "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"];

    const ctx = document.getElementById('counting_chart').getContext('2d');

    const existingChart = Chart.getChart(ctx);
    if (existingChart) {
        existingChart.destroy();
    }

    const config = {
        type: 'bar',
        data: {
            labels: monthsLabel,
            datasets: [
                {
                    label: 'Năm Trước',
                    data: lastData,
                    backgroundColor: '#60dbe8',
                    barPercentage: 1,
                    categoryPercentage: 0.5
                },
                {
                    type: 'line',
                    label: 'Năm Này',
                    data: thisData,
                    backgroundColor: '#d64e12',
                    borderColor: '#d64e12',
                    barPercentage: 1,
                    categoryPercentage: 0.5
                }
            ]
        },
        options: {
            indexAxis: 'x',
            responsive: true,
            scales: {
                x: {
                    stacked: false,
                    display: true,
                    title: {
                        display: true,
                        text: 'Tháng trong năm'
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Doanh thu (VNĐ)'
                    }
                }
            },
            plugins: {
                legend: {
                    position: 'top'
                },
                title: {
                    display: true,
                    text: 'Biểu đồ thể hiện doanh thu theo tháng của năm này và năm trước'
                },
                tooltip: {
                    callbacks: {
                        label: function(tooltipItem) {
                            return 'Doanh thu: ' + tooltipItem.raw + ' VNĐ';
                        }
                    }
                }
            }
            
        }
    };

    const chart = new Chart(ctx, config);
}

function calculateDaysOfWeek(date) {
    const daysOfWeek = ['Chủ Nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy'];
    const currentDate = new Date(date);
    const currentDayOfWeek = currentDate.getDay(); // CN-T7 : 0-6

    const days = [];

    const firstDayOfWeek = new Date(currentDate);
    firstDayOfWeek.setDate(currentDate.getDate() - currentDayOfWeek); // Tinh ra ngay chu nhat
    
    for (let i = 0; i < 7; i++) {
        const nextDay = new Date(firstDayOfWeek);
        nextDay.setDate(firstDayOfWeek.getDate() + i);
        days.push({
            dayName: daysOfWeek[nextDay.getDay()],
            //date: nextDay.toLocaleDateString() // format: dd/mm/yyyy
            date: nextDay
        });
    }

    return days;
}
function initCategoryChart(){
	Promise.all([getCate(), getCateRevenue()]).then((results) => {
        const [CateName, CateRevenue] = results;
        drawChartMonth(CateName, CateRevenue);
    }).catch(error => {
        console.error("Error in fetching week data:", error);
    });
}
initCategoryChart();