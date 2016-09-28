function searchUser(event){
  var key = document.getElementsByClassName("input-name-user")[0].value;
  document.getElementsByClassName("length-of-results")[0].textContent = "";
  document.getElementsByClassName("search-results")[0].textContent = "";   
  proxy("GET", "/api/users/" + key, "json").then(paintSearchResults).catch(paintFailedSearch);
}


function getSearchResults(response){
  var resultsContainer =  document.createDocumentFragment();
  var col_main = getCol("col-xs-offset-1 col-xs-10");

  for (var i = 0; i < response.length; i++) { 
    var button = getButton();
    var auth_token = getAuthToken();
    var col1 = getCol("col-xs-offset-1 col-xs-4 valign");   
    var col2 = getCol("col-xs-offset-2 col-xs-4");  
    col1.textContent = response[i].name;
    col2.appendChild(button);
    col2.appendChild(auth_token);

    var form = getForm(getRow(), col1, col2, response[i].id);    
    var row = getRow();
    var main_col = getCol("col-xs-offset-1 col-xs-10");

    main_col.appendChild(form);
    row.appendChild(main_col);

    col_main.appendChild(row);
  }

  resultsContainer.appendChild(col_main);
  return resultsContainer;
}

function getCol(formatClass){
  var col = document.createElement("div");
  col.className = formatClass; 

  return col;
}

function getRow(){
  var row = document.createElement("div");
  row.className = "row";
  row.style.margin = "1em"

  return row;
}

function getButton(){
  var button = document.createElement("button");
  button.setAttribute("type", "submit");
  button.textContent = "Send invitation"
  button.className = "btn btn-success"

  return button;
}

function getForm(row, col1, col2, id){
  var form = document.createElement("form");

  form.setAttribute("action", window.location.href.slice(0,-3) + id);        
  form.setAttribute("method", "post");

  row.appendChild(col1);
  row.appendChild(col2);  
  form.appendChild(row);
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

    document.getElementsByClassName("length-of-results")[0].textContent = 
    (response.length == 1) ?  "1 user matches the description" : response.length + " users match the description"
  }
}
  //hacerlo con la misma aplicacion ademas de via correos

function paintFailedSearch(response){
  console.log("Failed Response", response);
}