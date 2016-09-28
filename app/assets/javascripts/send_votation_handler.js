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