// document.getElementsByClassName("btn-input-user")[0].addEventListener("click", searchUser);

// function searchUser(event){
//   key = $(".input-name-user").val()
//   document.getElementsByClassName("length-of-results")[0].textContent = "";
//   document.getElementsByClassName("search-results")[0].textContent = "";    
//   $.ajax({
//     url: "/api/users/" + key,
//     success: paintSearchResults,
//     error: paintFailedSearch
//   });
// }

// function paintSearchResults(response){
//   console.log("Successful response", response);
//   var resultsContainer = document.createDocumentFragment();

//   if(response.length == 0){
//     document.getElementsByClassName("length-of-results")[0].textContent = "No user matches the description";
//   }
//   else{
//     for (var i = 0; i < response.length; i++) { 
//       var li = document.createElement("li");
//       li.textContent = response[i].name + " ";

//       var link = document.createElement("a");
//       var linkText = document.createTextNode("Send invitation");
//       link.setAttribute('href', "/api/users/" + response[i].email);
//       link.appendChild(linkText);
//       li.appendChild(link);
//       resultsContainer.appendChild(li);
//     }

//     console.log(document.getElementsByClassName("search-results")[0]);

//     document.getElementsByClassName("search-results")[0].appendChild(resultsContainer);

//     if(response.length == 1){
//       document.getElementsByClassName("length-of-results")[0].textContent = "1 user matches the description";
//     }
//     else {
//       document.getElementsByClassName("length-of-results")[0].textContent = response.length + " users matches the description";
//     }
//   }
//   //hacerlo con la misma aplicacion ademas de via correos
// }

// function paintFailedSearch(response){
//   console.log("Failed Response", response);
// }
