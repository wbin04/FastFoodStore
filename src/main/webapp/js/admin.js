const managerUser = document.querySelector('.manager_user');
const managerProduct = document.querySelector('.manager_product');
const managerOrder = document.querySelector('.manager_order');
const managerRating = document.querySelector('.manager_rating');
const managerCount = document.querySelector('.manager_count');
const iconRight = document.querySelector('.iconRight');
const iconDown = document.querySelector('.iconDown');
const managerOrderType = document.querySelector('.manager_orderType');

const adOrder_confirm = document.querySelector('.adOrder_confirm');
const adOrder_success = document.querySelector('.adOrder_success');
const adOrder_cancel = document.querySelector('.adOrder_cancel');

const userBack = document.querySelector('.user_back');
const productBack = document.querySelector('.product_back');
const addProductBack = document.querySelector('.addProduct_back');
const orderBack = document.querySelector('.order_back');

// const detailUser = document.querySelector('.detailUser');
const managerUserForm = document.querySelector('.managerUser_form');
const managerUserDetailForm = document.querySelector('.managerUserDetail_form');

// const detailProduct = document.querySelector('.detailProduct');
const managerProductForm = document.querySelector('.managerProduct_form');
const managerProductDetailForm = document.querySelector('.managerProductDetail_form');
const addProductBtn = document.querySelector('.add_productBtn');
const managerAddProductForm = document.querySelector('.managerAddProduct_form');
const addImageBtn = document.querySelector('.addImage');
const imgAddProd = document.querySelector('.img_addProd');
const setAddProdImage = document.querySelector('.setAddProdImage');

// const detailOrder = document.querySelector('.detailOrder');
const managerOrderForm = document.querySelector('.managerOrder_form');
const managerOrderDetailForm = document.querySelector('.managerOrderDetail_form');

let listUser = [];
let listProduct = [];
let listOrder = [];
let listOrderDetail = [];
const statuses = {
    confirm: 'Chờ xác nhận',
    success: 'Đã giao hàng',
    cancel: 'Đã huỷ'
}
let isFilter = false;
let isStatus;

const initApp = () => {
    Promise.all([
        fetch('users.json').then(response => response.json()),
        fetch('products.json').then(response => response.json()),
        fetch('order.json').then(response => response.json()),
        fetch('orderdetail.json').then(response => response.json())
    ]).then(([users, products, orders, orderDetails]) => {
        listUser = users;
        listProduct = products;
        listOrder = orders;
        listOrderDetail = orderDetails;

        console.table(listUser);
        console.table(listProduct);
        console.table(listOrder);
        console.table(listOrderDetail);

        addUserToHTML(listUser);
        addProductToHTML(listProduct);
        addOrderToHTML(listOrder);
        // addOrderDetailToHTML(listOrderDetail); // Uncomment if needed
    }).catch(error => {
        console.error('Error fetching data:', error);
    });
}

initApp();

const addUserToHTML = (userList) => {
    const listUserContainer = document.querySelector('.list_user');

    listUserContainer.innerHTML = '';

    userList.forEach(user => {
        const userItem = document.createElement('div');
        userItem.classList.add('userItem');

        userItem.innerHTML = `
            <div class="id_user">#${user.id}</div>
            <div class="name_user">${user.name}</div>
            <div class="phone_user">${user.phone}</div>
            <div class="email_user">${user.email}</div>
            <div class="detail_user"><i class="fa-solid fa-magnifying-glass detailUser"></i></div>
        `;

        const detailUser = userItem.querySelector('.detailUser');
        detailUser.addEventListener('click', () => {
            const selectedUserID = user.id;
            const selectedUser = listUser.find(user => user.id === selectedUserID);
        
            if (selectedUser) {
                resetManagerStyles();
                setManagerUser();
                managerUserForm.style.display = 'none';
                fillUserDetailForm(selectedUser);
            } else {
                alert('Không tìm thấy người dùng có ID này.');
            }
        });

        listUserContainer.appendChild(userItem);
    });
}

const addProductToHTML = (productList) => {
    const listProductContainer = document.querySelector('.list_product');

    listProductContainer.innerHTML = '';

    productList.forEach(product => {
        const productItem = document.createElement('div');
        productItem.classList.add('productItem');

        productItem.innerHTML = `
            <div class="id_product">#${product.id}</div>
            <div class="name_product">${product.name}</div>
            <div class="price_product">${product.price}</div>
            <div class="detail_product"><i class="fa-solid fa-magnifying-glass detailProduct"></i></div>
            <div class="delete_product"><i class="fa-solid fa-trash deleteProduct"></i></div>
        `;

        const detailProduct = productItem.querySelector('.detailProduct');
        detailProduct.addEventListener('click', () => {
            const selectedProdID = product.id;
            const selectedProd = productList.find(product => product.id === selectedProdID);
        
            if (selectedProd) {
                resetManagerStyles();
                setManagerProduct();
                managerProductForm.style.display = 'none';
                fillProductDetailForm(selectedProd);
            } else {
                alert('Không tìm thấy sản phẩm có addID này.');
            }
        });

        const deleteProduct = productItem.querySelector('.deleteProduct');
        deleteProduct.addEventListener('click', () => {
            const confirmDelete = document.querySelector('.confirmDelete_product');
            confirmDelete.style.display = 'flex';

            const confirmYes = confirmDelete.querySelector('.confirmOpt_yes');
            confirmYes.addEventListener('click', () => {
                const selectedProdID = product.id;
                deleteProductByID(selectedProdID);
                confirmDelete.style.display = 'none';
            });

            const confirmNo = confirmDelete.querySelector('.confirmOpt_no');
            confirmNo.addEventListener('click', () => {
                confirmDelete.style.display = 'none';
            });
        });

        listProductContainer.appendChild(productItem);
    });
}

const addOrderToHTML = (orderList) => {
    const listOrderContainer = document.querySelector('.list_order');

    listOrderContainer.innerHTML = '';

    orderList.forEach(order => {
        let totalPrice = 0;
        const ship = 15000;
        const detailOrder = listOrderDetail.filter(orderDetail => orderDetail.order_id == order.id);
        const userOrder = listUser.find(user => user.id == order.user_id);
        detailOrder.forEach(detailOrder => {
            const productOrder = listProduct.find(product => product.id == detailOrder.product_id);
            if (productOrder) {
                totalPrice += parseInt(productOrder.price) * parseInt(detailOrder.quantity);
            }
        });
        totalPrice += ship;
        // console.log(detailOrder, userOrder);
        
        const status = statuses[order.status];
        const orderItem = document.createElement('div');
        orderItem.classList.add('orderItem');

        orderItem.innerHTML = `
            <div class="id_order">#${order.id}</div>
            <div class="name_order">${userOrder.name}</div>
            <div class="address_order">${userOrder.address}</div>
            <div class="price_order">${totalPrice} VNĐ</div>
            <div class="status_order status_${order.status}">${status}</div>
            <div class="detail_order"><i class="fa-solid fa-magnifying-glass detailOrder"></i></div>
        `;

        const detailOrderBtn = orderItem.querySelector('.detailOrder');
        detailOrderBtn.addEventListener('click', () => {
            const selectedOrderID = order.id;
            const selectedOrder = orderList.find(order => order.id === selectedOrderID);
        
            if (selectedOrder) {
                resetManagerStyles();
                setManagerOrder();
                managerOrderForm.style.display = 'none';
                fillOrderDetailForm(selectedOrder);
            } else {
                alert('Không tìm thấy sản phẩm có addID này.');
            }
        });

        listOrderContainer.appendChild(orderItem);
    });
}

const addProductToOrderDetail = (order) => {
    const orderListProd_info = document.querySelector('.orderListProd_info');

    orderListProd_info.innerHTML = '';
    const detailOrder = listOrderDetail.filter(orderDetail => orderDetail.order_id == order.id);
    detailOrder.forEach(detailOrder => {
        const productOrder = listProduct.find(product => product.id == detailOrder.product_id);
        let totalPrice = 0;
        if (productOrder) {
            totalPrice += parseInt(productOrder.price ) * parseInt(detailOrder.quantity);
        }

        const orderProdItem = document.createElement('div');
        orderProdItem.classList.add('orderProdItem');

        orderProdItem.innerHTML = `
            <div class="orderProdItem_img">
                <img src="${productOrder.image}" alt="">
            </div>
            <div class="orderProdItem_info">
                <div class="orderProdItem_name">${detailOrder.quantity}x ${productOrder.name}</div>
                <div class="orderProdItem_price">${totalPrice} VNĐ</div>
            </div>
        `;

        orderListProd_info.appendChild(orderProdItem);
    });
}

const deleteUserByID = (userID) => {
    const index = listUser.findIndex(user => user.id == userID);

    if (index >= 0) {
        listUser.splice(index, 1);
        addUserToHTML(listUser);
        console.table(listUser);
    } else {
        // alert('Không tìm thấy sản phẩm có delID này.');
    }
}

const updateProductByID = (updatedProduct) => {
    const updatedProductID = updatedProduct.id;
    const indexToUpdate = listProduct.findIndex(product => product.id == updatedProductID);
    if (indexToUpdate !== -1) {
        listProduct[indexToUpdate] = updatedProduct;
        addProductToHTML(listProduct);

        console.log('Đã cập nhật sản phẩm thành công.');
    } else {
        console.error('Không tìm thấy sản phẩm cần cập nhật.');
    }
};

const deleteProductByID = (productID) => {
    const index = listProduct.findIndex(product => product.id == productID);

    if (index >= 0) {
        listProduct.splice(index, 1);
        addProductToHTML(listProduct);
        console.table(listProduct);
    } else {
        // alert('Không tìm thấy sản phẩm có delID này.');
    }
}

const updateStatusOrderByID = (updateOrder, updateStatus) => {
    const updateOrderID = updateOrder.id;
    const indexToUpdate = listOrder.findIndex(order => order.id == updateOrderID);
    if(indexToUpdate !== -1){
        listOrder[indexToUpdate].status = updateStatus;
        addOrderToHTML(listOrder);
        console.log(listOrder[indexToUpdate].status);
        console.log('Đã cập nhật đơn hàng thành công.');
    }
    else{
        console.error('Không tìm thấy đơn hàng cần cập nhật.');
    }
};

function resetManagerStyles(selectedManager) {
    const allManagers = [managerUser, managerProduct, managerOrder, managerRating, managerCount, adOrder_success, adOrder_confirm, adOrder_cancel];
    allManagers.forEach(manager => {
        manager.style.backgroundColor = '#fff';
    });

    managerOrderType.style.display = 'none';
    iconRight.style.display = 'inline-block';
    iconDown.style.display = 'none';

    managerUserForm.style.display = 'none';
    managerUserDetailForm.style.display = 'none';

    managerProductForm.style.display = 'none';
    managerProductDetailForm.style.display = 'none';
    managerAddProductForm.style.display = 'none';

    managerOrderForm.style.display = 'none';
    managerOrderDetailForm.style.display = 'none';
}

function setManagerUser() {
    resetManagerStyles(managerUser);
    managerUser.style.backgroundColor = '#f9e1cc';
    managerUserForm.style.display = 'flex';
}

function setManagerProduct() {
    resetManagerStyles(managerProduct);
    managerProduct.style.backgroundColor = '#f9e1cc';
    managerProductForm.style.display = 'flex';
}

function setManagerOrder() {
    resetManagerStyles(managerOrder);
    managerOrder.style.backgroundColor = '#f9e1cc';
    managerOrderForm.style.display = 'flex';
    managerOrderType.style.display = 'block';
    iconRight.style.display = 'none';
    iconDown.style.display = 'inline-block';
}

function setManagerRating() {
    resetManagerStyles(managerRating);
    managerRating.style.backgroundColor = '#f9e1cc';
}

function setManagerCount() {
    resetManagerStyles(managerCount);
    managerCount.style.backgroundColor = '#f9e1cc';
}

managerUser.addEventListener('click', setManagerUser);
managerProduct.addEventListener('click', setManagerProduct);
managerOrder.addEventListener('click', () => {
    setManagerOrder();
    isFilter = false;
    isStatus = '';
    addOrderToHTML(listOrder);
    
});
managerRating.addEventListener('click', setManagerRating);
managerCount.addEventListener('click', setManagerCount);

userBack.addEventListener('click', () => {
    resetManagerStyles();
    setManagerUser();
    // managerUserForm.style.display = 'flex';
});

productBack.addEventListener('click', () => {
    resetManagerStyles();
    setManagerProduct();
    // managerProductForm.style.display = 'flex';
});

addProductBack.addEventListener('click', () => {
    resetManagerStyles();
    setManagerProduct();
    managerProductForm.style.display = 'flex';
    imgAddProd.src = '';
    setAddProdImage.style.display = 'none';
    addImageBtn.textContent = 'Tải ảnh lên';
});

orderBack.addEventListener('click', () => {
    resetManagerStyles();
    setManagerOrder();
    // managerOrderForm.style.display = 'flex';
    if(isFilter){
        const filterStatus = {
            confirm: '.adOrder_confirm',
            success: '.adOrder_success',
            cancel: '.adOrder_cancel'
        }
        const statusSelector = filterStatus[isStatus];
        const statusButton = document.querySelector(statusSelector);
    
        if (statusButton) {
            const allButtons = document.querySelectorAll('.adOrder_confirm, .adOrder_success, .adOrder_cancel');
            allButtons.forEach(button => {
                button.style.backgroundColor = '#fff';
            });
    
            statusButton.style.backgroundColor = '#f9e1cc';
        }
    }
});

// detailUser.addEventListener('click', () => {
//     resetManagerStyles();
//     managerUserDetailForm.style.display = 'flex';
// });

function fillUserDetailForm(user) {
    const accIDInput = document.querySelector('.setAccID');
    const accNameInput = document.querySelector('.setAccName');
    const accNameUserInput = document.querySelector('.setAccNameUser');
    const accPhoneInput = document.querySelector('.setAccPhone');
    const accEmailInput = document.querySelector('.setAccEmail');
    const accAddressInput = document.querySelector('.setAccAddress');

    accIDInput.value = user.id;
    accNameInput.value = user.name;
    accNameUserInput.value = user.username;
    accPhoneInput.value = user.phone;
    accEmailInput.value = user.email;
    accAddressInput.value = user.address;

    // managerUser.style.backgroundColor = '#f9e1cc';
    managerUserDetailForm.style.display = 'flex';
}

// detailProduct.addEventListener('click', () => {
//     resetManagerStyles();
//     managerProductDetailForm.style.display = 'flex';
// });

function fillProductDetailForm(product) {
    const prodIDInput = document.querySelector('.setProdID');
    const prodNameInput = document.querySelector('.setProdName');
    const prodDescInput = document.querySelector('.setProdDesc');
    const prodPriceInput = document.querySelector('.setProdPrice');
    const prodImageInput = document.querySelector('.img_detailProd');
    const prodTypeInput = document.querySelector('.setProdType');

    prodIDInput.value = product.id;
    prodNameInput.value = product.name;
    prodDescInput.value = product.desc;
    prodPriceInput.value = product.price;
    prodImageInput.setAttribute('src', product.image);
    prodTypeInput.value = product.type;

    managerProduct.style.backgroundColor = '#f9e1cc';
    managerProductDetailForm.style.display = 'flex';
}

// detailOrder.addEventListener('click', () => {
//     resetManagerStyles();
//     managerOrderDetailForm.style.display = 'flex';
// });

function fillOrderDetailForm(order) {
    const orderCode = document.querySelector('.orderCode');
    const orderStatus = document.querySelector('.orderStatus');
    const customerName = document.querySelector('.customerName');
    const customerPhone = document.querySelector('.customerPhone');
    const customerAddress = document.querySelector('.customerAddress');
    const customerNote = document.querySelector('.customerNote');
    const orderTime = document.querySelector('.orderTime');
    // const optPayMethod = document.querySelector('.optPayMethod');
    const optCarriage = document.querySelector('.optCarriage');
    const orderTotalPrice = document.querySelector('.orderTotalPrice');

    const filterStatus = {
        confirm: '.adOrder_confirm',
        success: '.adOrder_success',
        cancel: '.adOrder_cancel'
    }
    const statusSelector = filterStatus[order.status];
    const statusButton = document.querySelector(statusSelector);

    if (statusButton) {
        const allButtons = managerOrderDetailForm.querySelectorAll('.adOrder_confirm, .adOrder_success, .adOrder_cancel');
        allButtons.forEach(button => {
            button.style.backgroundColor = '#fff';
        });

        statusButton.style.backgroundColor = '#f9e1cc';
    }

    const ship = 15000;
    let totalPrice = 0;
    const detailOrder = listOrderDetail.filter(orderDetail => orderDetail.order_id == order.id);
    const userOrder = listUser.find(user => user.id == order.user_id);
    detailOrder.forEach(detailOrder => {
        const productOrder = listProduct.find(product => product.id == detailOrder.product_id);
        if (productOrder) {
            totalPrice += parseInt(productOrder.price) * parseInt(detailOrder.quantity);
        }
    });
    totalPrice += ship;

    orderCode.textContent = `Mã đơn hàng: #${order.id}`;
    orderStatus.className = `orderStatus status_${order.status}`;
    orderStatus.textContent = statuses[order.status]; 
    customerName.value = userOrder.name;
    customerPhone.value = userOrder.phone;
    customerAddress.value = userOrder.address;
    customerNote.value = order.note;
    orderTime.textContent = `Thời gian đặt hàng: ${order.date}`;
    // optPayMethod.textContent = order.payment_method;
    optCarriage.textContent = `${ship} VNĐ`;
    orderTotalPrice.textContent = `${totalPrice} VNĐ`;

    managerOrderDetailForm.style.display = 'flex';

    addProductToOrderDetail(order);

    const hideButton = managerOrderDetailForm.querySelector('.orderBtnOption');
    const orderDetail_body = managerOrderDetailForm.querySelector('.orderDetail_body');
    if(order.status === 'confirm'){
        hideButton.style.display = 'flex';
        orderDetail_body.style.height = '72.5%%';
        orderDetail_body.style.borderBottom = '2px solid rgba(0,0,0,0.1)';
    }
    else{ 
        hideButton.style.display = 'none';
        orderDetail_body.style.height = '80%';
        orderDetail_body.style.borderBottom = 'none';
    }

    const optConfirm = managerOrderDetailForm.querySelector('.optConfirm');
    const optCancel = managerOrderDetailForm.querySelector('.optCancel');

    optConfirm.addEventListener('click', () => {
        const confirmSuccess_order = document.querySelector('.confirmSuccess_order');
        confirmSuccess_order.style.display = 'flex';

        const confirmYes = confirmSuccess_order.querySelector('.confirmOpt_yes');
        confirmYes.addEventListener('click', () => {
            updateStatusOrderByID(order, 'success');
            confirmSuccess_order.style.display = 'none';
            resetManagerStyles();
            setManagerOrder();
        });

        const confirmNo = confirmSuccess_order.querySelector('.confirmOpt_no');
        confirmNo.addEventListener('click', () => {
            confirmSuccess_order.style.display = 'none';
        });
    });

    optCancel.addEventListener('click', () => {
        const confirmCancel_order = document.querySelector('.confirmCancel_order');
        confirmCancel_order.style.display = 'flex';

        const confirmYes = confirmCancel_order.querySelector('.confirmOpt_yes');
        confirmYes.addEventListener('click', () => {
            updateStatusOrderByID(order, 'cancel');
            confirmCancel_order.style.display = 'none';
            resetManagerStyles();
            setManagerOrder();
        });

        const confirmNo = confirmCancel_order.querySelector('.confirmOpt_no');
        confirmNo.addEventListener('click', () => {
            confirmCancel_order.style.display = 'none';
        });
    });
}

const getNextProductId = () => {
    if (listProduct.length === 0) {
        return 1; 
    } else {
        const lastProductId = listProduct[listProduct.length - 1].id;
        return lastProductId + 1;
    }
};

addProductBtn.addEventListener('click', () => {
    resetManagerStyles();
    setManagerProduct();
    managerProductForm.style.display = 'none';
    document.querySelector('.setAddProdID').value = getNextProductId();
    managerAddProductForm.style.display = 'flex';
});

addImageBtn.addEventListener('click', () => {    
    const fileInput = document.createElement('input');
    fileInput.type = 'file';
    fileInput.accept = 'image/*';

    fileInput.addEventListener('change', (event) => {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                imgAddProd.src = e.target.result;
                setAddProdImage.style.display = 'block';
                addImageBtn.textContent = 'Thay đổi hình ảnh';
            };
            reader.readAsDataURL(file);
        }
    });

    fileInput.click();
});

let isConfirmed = false;
const optAdd = document.querySelector('.optAdd');
optAdd.addEventListener('click', () => {
    const prodIDInput = document.querySelector('.setAddProdID');
    const prodNameInput = document.querySelector('.setAddProdName');
    const prodDescInput = document.querySelector('.setAddProdDesc');
    const prodPriceInput = document.querySelector('.setAddProdPrice');
    const prodImageInput = document.querySelector('.img_addProd');
    const prodTypeInput = document.querySelector('.setAddProdType');

    // Kiểm tra xem các input và hình ảnh đã được chọn hay chưa
    const isInputValid = (
        prodNameInput.value.trim() !== '' &&
        prodDescInput.value.trim() !== '' &&
        prodPriceInput.value.trim() !== '' &&
        prodTypeInput.value.trim() !== '' &&
        prodImageInput.src.trim() !== 'http://127.0.0.1:5500/admin.html'
    );

    if (isInputValid) {
        const confirmAdd = document.querySelector('.confirmAdd_product');
        confirmAdd.style.display = 'flex';

        const confirmYes = confirmAdd.querySelector('.confirmOpt_yes');
        const confirmNo = confirmAdd.querySelector('.confirmOpt_no');

        confirmYes.addEventListener('click', () => {
            if (!isConfirmed) {
                const newProductID = getNextProductId();
                const product = {
                    id: newProductID,
                    name: prodNameInput.value,
                    desc: prodDescInput.value,
                    price: prodPriceInput.value,
                    image: prodImageInput.src,
                    type: prodTypeInput.value
                };

                console.log(product);
                listProduct.push(product);
                addProductToHTML(listProduct);

                resetManagerStyles();
                managerProductForm.style.display = 'flex';
                setAddProdImage.style.display = 'none';
                addImageBtn.textContent = 'Tải ảnh lên';

                prodIDInput.value = '';
                prodNameInput.value = '';
                prodDescInput.value = '';
                prodPriceInput.value = '';
                prodImageInput.src = '';
                prodTypeInput.value = '';

                confirmAdd.style.display = 'none';

                isConfirmed = true;
            }
        });

        confirmNo.addEventListener('click', () => {
            confirmAdd.style.display = 'none';
            isConfirmed = false;
        });
        
    } else {
        // alert('Vui lòng điền đầy đủ thông tin sản phẩm và tải lên hình ảnh.');
        const prodEmpty = document.querySelector('.confirmAdd_productEmpty');
        prodEmpty.style.display = 'flex';
        const confirmOK = prodEmpty.querySelector('.confirmOpt_yes');
        confirmOK.addEventListener('click', () => {
            prodEmpty.style.display = 'none';
        });
    }
});

const optEditLink = managerProductDetailForm.querySelector('.optEdit');
const optSaveBtn = managerProductDetailForm.querySelector('.optSave');
const optDel = managerProductDetailForm.querySelector('.optDel');
const productIDInput = managerProductDetailForm.querySelector('.setProdID');
const productNameInput = managerProductDetailForm.querySelector('.setProdName');
const productDescInput = managerProductDetailForm.querySelector('.setProdDesc');
const productPriceInput = managerProductDetailForm.querySelector('.setProdPrice');
const productImageInput = managerProductDetailForm.querySelector('.img_detailProd');
const productChangeImage = managerProductDetailForm.querySelector('.changeImage');
const productTypeInput = managerProductDetailForm.querySelector('.setProdType');

optEditLink.addEventListener('click', function(event) {
    // productIDInput.removeAttribute('readonly');
    productNameInput.removeAttribute('readonly');
    productDescInput.removeAttribute('readonly');
    productPriceInput.removeAttribute('readonly');
    productTypeInput.removeAttribute('readonly');

    productNameInput.focus();

    productChangeImage.style.display = 'block';
    productChangeImage.addEventListener('click', () => {    
        const fileInput = document.createElement('input');
        fileInput.type = 'file';
        fileInput.accept = 'image/*';
    
        fileInput.addEventListener('change', (event) => {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = (e) => {
                    productImageInput.src = e.target.result;
                    productChangeImage.textContent = 'Thay đổi hình ảnh';
                };
                reader.readAsDataURL(file);
            }
        });
    
        fileInput.click();
    });

    optSaveBtn.style.display = 'block';
    optDel.style.display = 'none';
});

optSaveBtn.addEventListener('click', function(event) {
    // productIDInput.setAttribute('readonly', true);
    productNameInput.setAttribute('readonly', true);
    productDescInput.setAttribute('readonly', true);
    productPriceInput.setAttribute('readonly', true);
    productTypeInput.setAttribute('readonly', true);

    const confirmUpdate = document.querySelector('.confirmUpdate_product');
    confirmUpdate.style.display = 'flex';

    const confirmYes = confirmUpdate.querySelector('.confirmOpt_yes');
    confirmYes.addEventListener('click', () => {
        const updateProduct = {
            id: productIDInput.value,
            name: productNameInput.value,
            desc: productDescInput.value,
            price: productPriceInput.value,
            image: productImageInput.src,
            type: productTypeInput.value
        };
        console.log(updateProduct);

        updateProductByID(updateProduct);
        
        confirmUpdate.style.display = 'none';
        optSaveBtn.style.display = 'none';
        optDel.style.display = 'block';
        productChangeImage.style.display = 'none';

        resetManagerStyles();
        managerProductForm.style.display = 'flex';
    });

    const confirmNo = confirmUpdate.querySelector('.confirmOpt_no');
    confirmNo.addEventListener('click', () => {
        confirmUpdate.style.display = 'none';
    });
});

optDel.addEventListener('click', () => {
    const confirmDelete = document.querySelector('.confirmDelete_product');
    confirmDelete.style.display = 'flex';

    const confirmYes = confirmDelete.querySelector('.confirmOpt_yes');
    confirmYes.addEventListener('click', () => {
        const selectedProdID = productIDInput.value;
        console.log(selectedProdID);
        deleteProductByID(selectedProdID);
        confirmDelete.style.display = 'none';
        resetManagerStyles();
        managerProductForm.style.display = 'flex';
    });

    const confirmNo = confirmDelete.querySelector('.confirmOpt_no');
    confirmNo.addEventListener('click', () => {
        confirmDelete.style.display = 'none';
    });
});

const deleteUser = managerUserDetailForm.querySelector('.delUserBtn');
deleteUser.addEventListener('click', () => {
    const confirmDelete = document.querySelector('.confirmDelete_user');
    confirmDelete.style.display = 'flex';

    const confirmYes = confirmDelete.querySelector('.confirmOpt_yes');
    confirmYes.addEventListener('click', () => {
        const selectedUserID = document.querySelector('.setAccID').value;
        deleteUserByID(selectedUserID);
        confirmDelete.style.display = 'none';
        resetManagerStyles();
        managerUserForm.style.display = 'flex';
    });

    const confirmNo = confirmDelete.querySelector('.confirmOpt_no');
    confirmNo.addEventListener('click', () => {
        confirmDelete.style.display = 'none';
    });
});

function filterOrderStatus(selectedStatus){
    const listFilterOrder = listOrder.filter(order => order.status === selectedStatus);
    // console.log(selectedStatus);
    isFilter = true;
    isStatus = selectedStatus;
    addOrderToHTML(listFilterOrder);
}

adOrder_confirm.addEventListener('click', () => {
    resetManagerStyles();
    setManagerOrder();
    adOrder_confirm.style.backgroundColor = '#f9e1cc';
    filterOrderStatus('confirm');
});

adOrder_success.addEventListener('click', () => {
    resetManagerStyles();
    setManagerOrder();
    adOrder_success.style.backgroundColor = '#f9e1cc';
    filterOrderStatus('success');
});

adOrder_cancel.addEventListener('click', () => {
    resetManagerStyles();
    setManagerOrder();
    adOrder_cancel.style.backgroundColor = '#f9e1cc';
    filterOrderStatus('cancel');
});

