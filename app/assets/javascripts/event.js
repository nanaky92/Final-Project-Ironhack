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

  var sendReminderButton = document.querySelector(".btn-send-reminder");

  if(sendReminderButton){
    var data = {"group": sendReminderButton.dataset.group, 
    "user": sendReminderButton.dataset.user, "event": sendReminderButton.dataset.event};
    sendReminderButton.addEventListener("click", sendReminderHandler(data));
  }


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
    proxy("PATCH", "/api/groups/events/finish/", "json", JSON.stringify(data)).then(paintSuccessMessage).catch(paintFailMessage);
  };
}

function sendRemindersHandler(data){
  return function(){
    proxy("POST", "/api/groups/events/send_reminders/", "json", JSON.stringify(data)).then(paintSuccessMessage).catch(paintFailMessage);
  };
}

function sendReminderHandler(data){
  return function(){
    proxy("POST", "/api/groups/events/send_reminder/", "json", JSON.stringify(data)).then(paintSuccessMessage).catch(paintFailMessage);
  };

}