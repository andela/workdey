function get_response(id){
  $.ajax({
    method:'GET',
    url:'/dashboard/notifications/'+id
  }).then(function(data){
    $('#question').html(data.question)
    $('#response').html(data.response)
  },function(req, status, error){
    console.log(error)
  })
}

function responseData(){
  return {
    notifiable_attr_to_update: { response: $("#response").val(), answered: true },
    reply_to_sender: true,
    message: "Enquiry",
    event_name: "Enquiry"
  };
};

function send_response(id) {
  $.ajax({
      url: ("/dashboard/notifications/" + id),
      method: "PUT",
      data: responseData()
    }).then(
    function(data){
      console.log(data)
    },
    function(req, status, error) {
      console.log(error)
  })
}

