document.addEventListener("DOMContentLoaded", function(event) { 
  setTimesForTimezones();
  setupInputSliders();
  setupButtons();
});


function setupInputSliders(){
  var inputs = document.querySelectorAll("input[type='range']");
  for (var i=0;i<inputs.length;i++){
    inputs[i].addEventListener("input", sliderHandler);
    setupSlider(inputs[i]);
  };

}

function setupButtons(){
  setupVotationButtons();

  var sendRemindersButton = document.querySelector(".btn-send-reminders");

  if(sendRemindersButton){
    var data = 
      {"group": sendRemindersButton.dataset.group, "event": sendRemindersButton.dataset.event};
    sendRemindersButton.addEventListener("click", sendRemindersHandler(data));
  }

}

function setupVotationButtons(){
  var sendVotationButton = document.querySelector(".btn-send-votation");
  var notGoingButton = document.querySelector(".btn-not-going");
  
  if(sendVotationButton) 
    sendVotationButton.addEventListener("click", sendVotationHandler);

  if(notGoingButton) 
    notGoingButton.addEventListener("click", notGoingHandler);

  var finishVotationButton = document.querySelector(".btn-finish-votation");

  if(finishVotationButton){
    var data = 
      {"group": finishVotationButton.dataset.group, "event": finishVotationButton.dataset.event};
    finishVotationButton.addEventListener("click", finishVotationHandler(data));
  }  
}


function finishVotationHandler(data){
  return function(){
    $.ajax({
      url: "/api/groups/events/votations/finish",
      success: paintSuccessMessage,
      error: paintFailMessage,
      data: data,
      method: "patch"
    })
  };
}

function sendRemindersHandler(data){
  return function(){
    $.ajax({
      url: "/api/groups/events/send_reminders",
      success: paintSuccessMessage,
      error: paintFailMessage,
      data: data,
      method: "post"
    })
  };

}