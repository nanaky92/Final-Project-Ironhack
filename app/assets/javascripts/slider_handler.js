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
