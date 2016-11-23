$(".notification-feed").on("click", ".btn", function (e) {
  if($(this).data("notification-type") != "Quote") return

  var notificationId = $(this).data("id"),
      service_id = $(this).data("notifiable-id"),
      displayContext = $(".full_notification_message");

  get_service_record(service_id).done(function(service_record){
    get_notifiable_record(notificationId).done(function(quote_record){
      display_full_message(quote_record, service_record, displayContext, notificationId);
      $('#notification-ok').on('click', function(){
        displayContext.empty();
        remove_notification(notificationId);
      })
    })
  });
})

function get_service_record(service_id){
  return $.ajax({
      url: "/services/" + service_id,
      method: "GET",
      dataType: "json"
    });
}

function display_full_message(quote_record, service_record, display_context, notification_id){
  service_title = $("<h5 class='center-align'>").text("Service Description");
  service_text = $("<p>").text(service_record.service.description);
  quote_title = $("<h5 class='center-align'>").text("Quote Details");
  quote_text = $("<p>").text(quote_record.status + " quote: $" + quote_record.quoted_value);
  tasker_title = $("<h5 class='center-align'>").text("Tasker Details");
  tasker_name = $("<p>").text("Name: " + service_record.tasker.firstname + " " + service_record.tasker.lastname)
  tasker_email= $("<p>").text("Email: " + service_record.tasker.email);
  tasker_phone = $("<p>").text("Phone: " + service_record.tasker.phone);
  ok_button = $("<button id='notification-ok' style='margin-left: 33%' class='btn waves-effect waves-light teal center-align' data-notification-id=" + notification_id + ">")
  .html("<i class='material-icons left'>thumb_up</i> OK");

  display_context.empty().removeClass("center-align").append(
    service_title,
    service_text,
    $("<hr>"),
    quote_title,
    quote_text
  );

  if (quote_record.status == "accepted"){
    display_context.append(
      $("<hr>"),
      tasker_title,
      tasker_name,
      tasker_email,
      tasker_phone
    );
  }

  display_context.append(ok_button);
}
