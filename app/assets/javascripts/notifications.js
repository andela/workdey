(function () {
  $(".notification-feed").on("click", ".btn", function () {
    var requestId = $(this).data("id"),
        title = $(this).prev(".title").text().trim()
        request = $.ajax({
          url: ("/dashboard/notifications/" + requestId),
          method: "POST",
          data: { title: title },
          dataType: "json"
        });

    $(this).closest(".feed").addClass("viewed");

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

      $(".actions").on("click", function (e) {
        var elem = $(e.target),
            notificationFeed = $(".notification-feed"),
            userAction;

        if (elem.data("accept")) {
          userAction = $.ajax({
            url: ("/dashboard/notifications/" + elem.data("accept")),
            method: "PUT",
            data: { status: "active" }
          }).done(function () {
            swal({
              title: "Task accepted",
              text: "You can view all your assigned tasks from the manage tasks page",
              type: "success",
              confirmButtonColor: "#eb4d5c"
            });

            displayContext.empty().append("<p>Click on the view button to get more information about a task</p>")
              .append("<i class='material-icons'>directions_bike</i>");

            $(".feed .btn[data-id=" + elem.data("accept") + "]").closest(".feed").css("opacity", 0);

            window.setTimeout(function () {
              $(".feed .btn[data-id=" + elem.data("accept") + "]").closest(".feed").remove();
            }, 1000);

            if (notificationFeed.children().length === 1) {
              displayContext.empty().append("<p>No new notifications available</p>")
              .append("<i class='material-icons'>highlight_off</i>")
              .append("<i class='material-icons'>highlight_off</i>")
              .append("<i class='material-icons'>highlight_off</i>")
              .append("<i class='material-icons'>highlight_off</i>");
            }
          });
        } else {
          userAction = $.ajax({
            url: ("/dashboard/notifications/" + elem.data("reject")),
            method: "PUT",
            data: { status: "rejected" }
          }).done(function () {
            swal({
              title: "Task rejected",
              text: "The tasker will be notified of your choice",
              type: "error",
              confirmButtonColor: "#eb4d5c"
            });

            displayContext.empty().append("<p>Click on the view button to get more information about a task</p>")
              .append("<i class='material-icons'>directions_bike</i>");

            $(".feed .btn[data-id=" + elem.data("reject") + "]").closest(".feed").css("opacity", 0);

            window.setTimeout(function () {
              $(".feed .btn[data-id=" + elem.data("reject") + "]").closest(".feed").remove();
            }, 1000);

            if (notificationFeed.children().length === 1) {
              displayContext.empty().append("<p>No new notifications available</p>")
              .append("<i class='material-icons'>highlight_off</i>")
              .append("<i class='material-icons'>highlight_off</i>")
              .append("<i class='material-icons'>highlight_off</i>")
              .append("<i class='material-icons'>highlight_off</i>");
            }
          });
        }
      });
    });

    request.fail(function (msg) {
      return false
    });
  });

}());