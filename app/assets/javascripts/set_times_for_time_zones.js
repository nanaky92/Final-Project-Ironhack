function setTimesForTimezones(){
  var offset = new Date().getTimezoneOffset();
  var datetimes = document.querySelectorAll(".time-with-time-zone");

  var monthNames = ["Jan", "Feb", "March", "April", "May", "June",
  "July", "Aug", "Sept", "Oct", "Nov", "Dec"];

  for(var i = 0; i < datetimes.length; i++){
    var d = new Date(datetimes[i].innerHTML.trim());
    // datetimes[i].innerHTML = `${d.getDate()} ${monthNames[d.getMonth()]} ${String(d.getFullYear()).slice(2,4)} 
    // ${d.toLocaleTimeString()}`;    
    datetimes[i].innerHTML = d.getDate() + " " + monthNames[d.getMonth()] + " " + 
    String(d.getFullYear()).slice(2,4) + " " + d.toLocaleTimeString();      
  
  }
}
