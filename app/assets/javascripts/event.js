function setTimesForTimezones(){
  var offset = new Date().getTimezoneOffset();
  var datetimes = $(".time-with-time-zone");

  var monthNames = ["Jan", "Feb", "March", "April", "May", "June",
  "July", "Aug", "Sept", "Oct", "Nov", "Dec"];

  for(var i = 0; i < datetimes.length; i++){
    var d = new Date(datetimes[i].innerHTML.trim());
    datetimes[i].innerHTML = d.getDate() + " " + monthNames[d.getMonth()] + " " 
    + String(d.getFullYear()).slice(2,4) + " " + d.toLocaleTimeString();      
  }
}


function sliderHandler(){
    var val = parseInt(this.value);
    var id = this.dataset.id;
    
    if (val > 100) {
      val = 100;
    }
    else if (val < 0) {
      val = 0;
    }

    $("span.value[data-id=" + id + "]").text(val);

    var   red = new Color(232, 9, 26),
          white = new Color(255, 255, 255),
          green = new Color(6, 170, 60),
          start = red,
          end = white;

      if (val > 50) {
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
};

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

function paintSuccessMessage(){
  console.log("He llorado");
}


// Terminar
function sendVotationHandler(){
  var data;
  $.post(
    "createVotation",
    data,
    paintSuccessMessage
    )
}


document.addEventListener("DOMContentLoaded", function(event) { 
  setTimesForTimezones();

  var inputs = document.querySelectorAll("input[type='range']");
  for (var i=0;i<inputs.length;i++){
    inputs[i].addEventListener("change", sliderHandler);
  };

  var inputs = document.querySelectorAll("input[type='range']");
  for (var i=0;i<inputs.length;i++){
    inputs[i].addEventListener("change", sliderHandler);
  };

  document.querySelector(".btn-send-votation").addEventListener("click", sendVotationHandler);

});