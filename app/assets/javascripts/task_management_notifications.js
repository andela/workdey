function respond_to_service_request(obj, urlParam, btnId) {
  var displayContext = $(".full_notification_message"),
      notificationFeed = $(".notification-feed"),
      actionElem = $(".feed .btn[data-id=" + btnId + "]").closest(".feed"),
      userAction;

      function userActionData(){
        return {
          notifiable_attr_to_update: { status: obj.status },
          reply_to_sender: false
        };
      }

      //send artisan response
      userAction = $.ajax({
        url: ("/dashboard/notifications/" + urlParam),
        method: "PUT",
        data: userActionData()
      });

      display_confirmation_alert(obj.status);
      displayContext.empty();
      remove_notification(btnId);
}

$(".notification-feed").on("click", ".btn", function (e) {
  var requestId = $(this).data("id"),
      messageTitle = $(this).prev(".title").text().trim()
      request = get_notifiable_record(requestId);
  request.done(function(notifiableObj) {
    var endDate = new Date(notifiableObj.end_date).toDateString(),
        startDate = new Date(notifiableObj.start_date).toDateString();

    var displayContext = $(".full_notification_message");

    if (notifiableObj.expired){
      var title = $("<h5>").text("Notification Expired"),
          content = $("<p>").text("Please note that service request\
           notifications expire within 30 minutes\
           \nAlso, missing notifications lowers your rating"),
          action_button = $("<button id='expired-notification-confirmation'class='btn waves-effect waves-light teal'>")
                      .html("OK");
      displayContext.empty().append(title).append(content).append(action_button);
      $('#expired-notification-confirmation').on('click', function(){
        $('.full_notification_message').empty();
        remove_notification(requestId)
      })
    }
    else{
      var title = $("<h5>").text(messageTitle),
          content = $("<p>")
                      .html(notifiableObj.description +
                            "<br>Start Date: <strong>" + startDate +
                             "</strong>\
                             <br>End Date: <strong>" + endDate + "</strong>"
                            ),
          actions = $("<div class='actions'>"),
          accept = $("<button class='btn waves-effect waves-light teal' data-accept=" + requestId + ">")
                      .html("<i class='material-icons left'>thumb_up</i> Accept"),
          reject = $("<button class='btn waves-effect waves-light' data-reject=" + requestId + ">")
                      .html("<i class='material-icons left'>thumb_down</i> Reject");

      actions.append(accept).append(reject)
      displayContext.empty().append(title).append(content).append(actions);
    }


    $(".actions").on("click", function(e) {
      var elem = $(e.target),
          notificationFeed = $(".notification-feed");

      if (elem.data("accept")) {
        displayContext.empty().append(title).append(content).append(artisan_quote_input());
        $('#send-quote').on('click', function(){
          if (is_quoted_value_empty()){
            $('#quote_value_error').empty().append('You must enter a quote');
            return;
          }
          if (quoted_value_is_zero_or_negative()){
            $('#quote_value_error').empty().append('Quote value must be greater than 0');
            return;
          }
          if (quoted_value_has_non_numeric_characters()){
            $('#quote_value_error').empty().append('Quote value must be a number');
            return;
          }
          send_quote(notifiableObj.id)
          respond_to_service_request({status: "accepted"}, requestId, elem.data("accept"));
        })
      } else {
        respond_to_service_request({status: "unassigned"}, requestId, elem.data("reject"));
      }
    });
  });
})

function display_confirmation_alert(user_choice){
  var alert_type, alert_title, alert_text;
  if (user_choice === "accepted"){
    alert_type = "success";
    alert_title = "Task Accepted";
    alert_text = "You have accepted to perform this task with a quote of $" +
    quoted_value();
  }
  else {
    alert_type = "error";
    alert_title = "Task Rejected.";
    alert_text = "You have rejected this task.\n\
     Please note that rejecting tasks lowers your rating.";
  }
  swal({
    title: alert_title,
    text: alert_text,
    type: alert_type,
    confirmButtonColor: "#eb4d5c"
  });
}

function remove_notification(notification_id){
  $('#notification-item-' + notification_id).remove();
  if ($('.notification-feed').has('div').length == 0){
    $('.notification-feed').append('<p>You have no new notifications</p>');
  }
}

function get_notifiable_record(notifiable_id){
  return $.ajax({
    url: ("/dashboard/notifications/" + notifiable_id),
    method: "GET",
    dataType: "json"});
}
