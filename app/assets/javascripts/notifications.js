function get_response(id){
  $.ajax({
    method:'GET',
    url:'/dashboard/notifications/'+id
  }).then(function(data){
    $('#question').html(data.question)
    $('#response').html(data.response)
  },function(req, status, error){
    console.log(error)
  });
};

function responseData(){
  return {
    notifiable_attr_to_update: { response: $("#response").val(), answered: true },
    reply_to_sender: true,
    message: "Enquiry Response",
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
  });
};

function task_details(sender, task, id){
  var endDate = new Date(task.end_date).toDateString(),
      startDate = new Date(task.start_date).toDateString();
      $("span#sender").html(sender.firstname+ " "+ sender.lastname);
     $("span#startDate").html(startDate);
     $("span#endDate").html(endDate);
     $("span#message").html(task.name);
     $("span#description").html(task.description);
     $("span#lower_bound").html(task.price_range[0]);
     $("span#upper_bound").html(task.price_range[1]);
     $.get( "/dashboard/notifications/"+ id);
 };

function task_response_data(action) {
  if (action == "active") {
    artisan_response = "Artisan accepted your task"
  } else {
    artisan_response = "Artisan rejected your task"
  }
  return {
    notifiable_attr_to_update: { status: action },
    reply_to_sender: true,
    message: artisan_response,
    event_name: "new task"
  };
};

function task_response(action,id){
  swalTitle = action === "active" ? "Task accepted" : "Task rejected",
  swalText =
    action === "active" ?
      "You can view all your assigned tasks from the manage tasks page" :
      "The tasker will be notified of your choice",
  swalType = action === "active" ? "success" : "error",
  swalBtnColor = "#eb4d5c";
     $.ajax({
       url: ("/dashboard/notifications/" + id),
       method: "PUT",
       data: task_response_data(action)
     }).done(function(data){
       swal({
         title: swalTitle,
         text: swalText,
         type: swalType,
         confirmButtonColor: swalBtnColor
       });

     });
 };
