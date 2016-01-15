(function () {
  $(".notification-feed").on("click", ".btn", function (e) {
    var requestId = $(this).data("id"),
        title = $(this).prev(".title").text().trim()
        request = $.ajax({
          url: ("/dashboard/notifications/" + requestId),
          method: "POST",
          data: { id: requestId, title: title },
          dataType: "json"
        });

    request.done(function (msg) {
      var displayContext = $(".full_notification_message"),
          title = $("<h5>").text(msg.title),
          content = $("<p>")
                      .html(msg.description +
                            ", I want this task to be done on <strong>" +
                            msg.date + "</strong> by <strong>" + msg.time + "</strong> for the price of " +
                            "<strong>" + msg.amount + "<strong>"
                            ),
          actions = $("<div class='actions'>"),
          accept = $("<button class='btn' data-accept=" + requestId + ">")
                      .html("<i class='material-icons left'>thumb_up</i> Accept"),
          reject = $("<button class='btn' data-reject=" + requestId + ">")
                      .html("<i class='material-icons left'>thumb_down</i> Reject");

      actions.append(accept).append(reject)
      displayContext.empty().append(title).append(content).append(actions);
    });

    request.fail(function (msg) {
      return false
    });
  });
}());