function paintSuccessMessage(response){
  // console.log(response);
  document.querySelector(".error-messages").innerHTML = "";
  document.querySelector(".success-messages").innerHTML = response.message;
}

function paintFailMessage(response){
  // console.log(response);
  document.querySelector(".error-messages").innerHTML = response.responseJSON.message;
  document.querySelector(".success-messages").innerHTML = "";
}

