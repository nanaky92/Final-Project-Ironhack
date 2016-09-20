function searchUser(event){
  var key = document.getElementsByClassName("input-name-user")[0].value;
  document.getElementsByClassName("length-of-results")[0].textContent = "";
  document.getElementsByClassName("search-results")[0].textContent = "";    
  $.ajax({
    url: "/api/users/" + key,
    success: paintSearchResults,
    error: paintFailedSearch
  });
}



function getSearchResults(response){
  var resultsContainer =  document.createDocumentFragment();

  for (var i = 0; i < response.length; i++) { 
    var button = getButton();
    var auth_token = getAuthToken();
    var col1 = getCol("col-xs-offset-1 col-xs-4");   
    var col2 = getCol("col-xs-offset-2 col-xs-4");  
    col1.textContent = response[i].name;
    col2.appendChild(button);
    col2.appendChild(auth_token);

    var form = getForm(col1, col2, response[i].id);    
    var row = getRow(form);

    resultsContainer.appendChild(row);
  }

  return resultsContainer;
}


function getCol(formatClass){
  var col = document.createElement("div");
  col.className = formatClass; 

  return col;
}

function getRow(form){
  var row = document.createElement("div");
  row.className = "row";
  row.style.margin = "1em"
  row.appendChild(form);

  return row;
}

function getButton(){
  var button = document.createElement("button");
  button.setAttribute("type", "submit");
  button.textContent = "Send invitation"
  button.className = "btn btn-primary"

  return button;
}

function getForm(col1, col2, id){
  var form = document.createElement("form");

  form.setAttribute("action", window.location.href + "/" + id);        
  form.setAttribute("method", "post");

  form.appendChild(col1);
  form.appendChild(col2);  

  return form;
}
  
function getAuthToken(){
    var auth_token = document.createElement("input");
    auth_token.setAttribute("name", "authenticity_token");
    auth_token.setAttribute("type", "hidden");

    var AUTH_TOKEN = document.querySelector("[name=csrf-token]").content;
    auth_token.setAttribute("value", AUTH_TOKEN);
    return auth_token;
}

function paintSearchResults(response){

  if(response.length == 0){
    document.getElementsByClassName("length-of-results")[0].textContent = "No user matches the description";
  }
  else {

    var resultsContainer = getSearchResults(response);

    document.getElementsByClassName("search-results")[0].appendChild(resultsContainer);

    if(response.length == 1){
      document.getElementsByClassName("length-of-results")[0].textContent = "1 user matches the description";
    }
    else {
      document.getElementsByClassName("length-of-results")[0].textContent = response.length + " users match the description";
    }
  }
}
  //hacerlo con la misma aplicacion ademas de via correos



// function paintSearchResults(response){

//   var resultsContainer = document.createDocumentFragment();

//   if(response.length == 0){
//     document.getElementsByClassName("length-of-results")[0].textContent = "No user matches the description";
//   }
//   else{
//     for (var i = 0; i < response.length; i++) { 
//       // var p = document.createElement("p");

//       var form = document.createElement("form");
//       // form.textContent = response[i].name + " ";

//       // console.log(window.location.href)
//       form.setAttribute("action", window.location.href + "/" + response[i].id);        
//       form.setAttribute("method", "post");
      
//       var button = document.createElement("button");
//       button.setAttribute("type", "submit");
//       button.textContent = "Send invitation"

//       button.className = "btn btn-primary"
      
//       var auth_token = document.createElement("input");
//       auth_token.setAttribute("name", "authenticity_token");
//       auth_token.setAttribute("type", "hidden");

//       var AUTH_TOKEN = document.querySelector("[name=csrf-token]").content;
//       auth_token.setAttribute("value", AUTH_TOKEN);

//       var row = document.createElement("div");
//       row.className = "row";

//       var col1 = document.createElement("div");
//       col1.className = "col-xs-offset-1 col-xs-4";      

//       var col2 = document.createElement("div");
//       col2.className = "col-xs-offset-2 col-xs-4";      

//       col1.textContent = response[i].name;
//       col2.appendChild(button);
//       col2.appendChild(auth_token);

//       form.appendChild(col1);
//       form.appendChild(col2);

//       row.appendChild(form);

//       resultsContainer.appendChild(row);
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

function paintFailedSearch(response){
  console.log("Failed Response", response);
}

// $(document).ready(document.getElementsByClassName("btn-input-user")[0].addEventListener("click", searchUser))

document.addEventListener("DOMContentLoaded", function(event) { 
  document.getElementsByClassName("btn-input-user")[0].onclick = searchUser;
});

// document.addEventListener("DomContentLoaded", function(){ alert('Dom') }, false);
// document.addEventListener("DOMContentLoaded", function(){ alert('DOM') }, false);
