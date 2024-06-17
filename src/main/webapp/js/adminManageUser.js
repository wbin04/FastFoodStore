$(document).ready(function(){
	$('.search_icon').click(function(){
		var text = $('.search_text').val();
		console.log(text);
		window.location = "http://localhost:8080/FastFood/adminManageUser?key=" + text;
	})
})

const managerUser = document.querySelector('.manager_user');
const managerUserForm = document.querySelector('.managerUser_form');
function setManagerUser() {
    // resetManagerStyles(managerUser);
    managerUser.style.backgroundColor = '#f9e1cc';
    managerUserForm.style.display = 'flex';
	console.log(1);
}

setManagerUser();