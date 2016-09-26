document.addEventListener("DOMContentLoaded", function(event) { 

  var finishVotationButton = document.querySelector(".btn-finish-votation");

  if(finishVotationButton){
    var data = {"group": finishVotationButton.dataset.group, "event": finishVotationButton.dataset.event};
    
    finishVotationButton.addEventListener("click", finishVotationHandler(data));
  }
});

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
