function responseData(action){
  return {
    notifiable_attr_to_update: { status: action },
    reply_to_sender: true,
    message: "Your Quote was " + action,
    event_name: "Quote"
  };
};

function quotation(action,id){
    $.ajax({
      url: ("/dashboard/notifications/" + id),
      method: "PUT",
      data: responseData(action)
    }).then(function(data){
      $('#quote_accept').hide()
      $('#quote_reject').hide()
      $('#information').show()
    });
}
$(document).ready(function(){
  $('#information').hide()
})
