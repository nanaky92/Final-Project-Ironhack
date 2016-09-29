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

    ajaxVotation(data);
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

    ajaxVotation(data);
  }
}

function ajaxVotation(data){

  proxy("PATCH", "/api/groups/events/votations/", "json", JSON.stringify(data)).then(paintSuccessMessage).catch(paintFailMessage);
  
}