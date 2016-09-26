document.addEventListener("DOMContentLoaded", function(event) { 
  var btns = document.getElementsByClassName("btn-input-user");
  if(btns.length == 1)
    btns[0].onclick = searchUser;
});