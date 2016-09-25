document.addEventListener("DOMContentLoaded", function(event) { 
  setTimesForTimezones();

  var inputs = document.querySelectorAll("input[type='range']");
  for (var i=0;i<inputs.length;i++){
    inputs[i].addEventListener("input", sliderHandler);
    setupSlider(inputs[i]);
  };
  
  var sendVotationButton = document.querySelector(".btn-send-votation");
  var notGoingButton = document.querySelector(".btn-not-going");
  
  if(sendVotationButton) 
    sendVotationButton.addEventListener("click", sendVotationHandler);

  if(notGoingButton) 
    notGoingButton.addEventListener("click", notGoingHandler);

});

function setTimesForTimezones(){
  var offset = new Date().getTimezoneOffset();
  var datetimes = document.querySelectorAll(".time-with-time-zone");

  var monthNames = ["Jan", "Feb", "March", "April", "May", "June",
  "July", "Aug", "Sept", "Oct", "Nov", "Dec"];

  for(var i = 0; i < datetimes.length; i++){
    var d = new Date(datetimes[i].innerHTML.trim());
    datetimes[i].innerHTML = `${d.getDate()} ${monthNames[d.getMonth()]} ${String(d.getFullYear()).slice(2,4)} 
    ${d.toLocaleTimeString()}`;      
  }
}


function sliderHandler(){
  var val = filterValue(this.value);
  var id = this.dataset.id;

  this.parentNode.childNodes[1].innerHTML = val;

  changeColorToSlider(val, id);
};

function filterValue(val_s){
  var val = parseInt(val_s);
  val = (val > 100) ? 100 : val;
  val = (val < 0) ? 0 : val;
  return val;
}

function setupSlider(input){
  var val = filterValue(input.parentNode.childNodes[1].innerHTML.trim());
  var id = input.dataset.id;

  input.value = val;

  changeColorToSlider(val, id);
};

function changeColorToSlider(val, id){
  var red = new Color(232, 9, 26),
  white = new Color(255, 255, 255),
  green = new Color(6, 170, 60),
  start = red,
  end = white;

  if(val > 50) {
    start = white;
    end = green;
    val = val % 51;
  }

  var startColors = start.getColors(),
  endColors = end.getColors();
  var r = Interpolate(startColors.r, endColors.r, 50, val);
  var g = Interpolate(startColors.g, endColors.g, 50, val);
  var b = Interpolate(startColors.b, endColors.b, 50, val);

  document.querySelector(".slider-change-color[data-id='" + id + "']").style.backgroundColor = "rgb(" + r + "," + g + "," + b + ")";

}


function Interpolate(start, end, steps, count) {
  var s = start,
  e = end,
  final = s + (((e - s) / steps) * count);
  return Math.floor(final);
}

function Color(_r, _g, _b) {
  var r, g, b;
  var setColors = function(_r, _g, _b) {
    r = _r;
    g = _g;
    b = _b;
  };

  setColors(_r, _g, _b);
  this.getColors = function() {
    var colors = {
      r: r,
      g: g,
      b: b
    };
    return colors;
  };
}

function paintSuccessMessage(response){
  document.querySelector(".error-messages").innerHTML = "";
  document.querySelector(".success-messages").innerHTML = response.message;
}

function paintFailMessage(response){
  console.log(response.responseJSON.message);
  document.querySelector(".error-messages").innerHTML = response.responseJSON.message;
  document.querySelector(".success-messages").innerHTML = "";
}


function notGoingHandler(){
  var data = {};
  var inputs = document.querySelectorAll(".value-from-slider");
  if(inputs.length!=0){
    for (var i=0; i<inputs.length; i++){
      inputs[i].innerHTML = 0;
      var id = inputs[i].dataset.id;
      inputs[i].parentNode.childNodes[3].value = 0;
      changeColorToSlider(0, id);
      data["votation" + String(inputs[i].dataset.id).trim()] = 0;
    };

    data["group"] = inputs[0].dataset.group;
    data["event"] = inputs[0].dataset.event;

    ajaxVotation(inputs, data);
  }

}


function sendVotationHandler(){
  var data = {}
  var inputs = document.querySelectorAll(".value-from-slider");
  if(inputs.length!=0){
  
    for (var i=0; i<inputs.length; i++){
      data["votation" + String(inputs[i].dataset.id).trim()] = inputs[i].innerHTML.trim();
    };
  
    data["group"] = inputs[0].dataset.group;
    data["event"] = inputs[0].dataset.event;

    ajaxVotation(inputs, data);
  }
}

function ajaxVotation(inputs, data){
  
  $.ajax({
    url: "/api/groups/events/votations/",
    success: paintSuccessMessage,
    data: data,
    error: paintFailMessage,
    method: "patch"
  });
}



    // proxy("post", "/api/groups/events/votations/", "json", JSON.stringify(data)).then(paintSuccessMessage).catch(console.log(response));

    // $.ajax({
    //   url: "/groups/" + inputs[0].dataset.group + "/events/" + inputs[0].dataset.event + "/votations/" + JSON.stringify(data),
    //   success: paintSuccessMessage,
    //   error: function(response){console.log(response)},
    //   method: "patch"
    // });