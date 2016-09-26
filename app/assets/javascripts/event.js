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


