(function () {
  function sendDbReq(obj, urlParam, btnId) {
    var displayContext = $(".full_notification_message"),
        notificationFeed = $(".notification-feed"),
        actionElem = $(".feed .btn[data-id=" + btnId + "]").closest(".feed"),
        swalTitle = obj.status === "active" ? "Task accepted" : "Task rejected",
        swalText =
          obj.status === "active" ?
            "You can view all your assigned tasks from the manage tasks page" :
            "The tasker will be notified of your choice",
        swalType = obj.status === "active" ? "success" : "error",
        swalBtnColor = "#eb4d5c",
        userAction,
        taskee_response;

    function userActionData() {
      if (obj.status === "active") {
        taskee_response = "Taskee accepted your task"
      } else {
        taskee_response = "Taskee rejected your task"
      }
      return {
        notifiable_attr_to_update: { status: obj.status },
        reply_to_sender: true,
        message: taskee_response
      };
    };

    userAction = $.ajax({
      url: ("/dashboard/notifications/" + urlParam),
      method: "PUT",
      data: userActionData()
    });

    userAction.done(function () {
      swal({
        title: swalTitle,
        text: swalText,
        type: swalType,
        confirmButtonColor: swalBtnColor
      });

      displayContext.empty().append("<p>Click on the view button to get more information about a task</p>")
        .append("<i class='material-icons'>directions_bike</i>");

      actionElem.css("opacity", 0);

      window.setTimeout(function () {
        actionElem.remove();
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

  $(".notification-feed").on("click", ".btn", function (e) {
    var requestId = $(this).data("id"),
        messageTitle = $(this).prev(".title").text().trim()
        request = $.ajax({
          url: ("/dashboard/notifications/" + requestId),
          method: "GET",
          dataType: "json"
        });

    $(this).closest(".feed").addClass("viewed");

    request.done(function(notifiableObj) {
      var endDate = new Date(notifiableObj.end_time).toDateString(),
          startDate = new Date(notifiableObj.start_time).toDateString();

      var displayContext = $(".full_notification_message"),
          title = $("<h5>").text(messageTitle),
          content = $("<p>")
                      .html(notifiableObj.task_desc +
                            ", I want this task to be done on <strong>" +
                            startDate + "</strong> by <strong>" + endDate + "</strong> for the price of " +
                            "<strong>" + notifiableObj.amount + "<strong>"
                            ),
          actions = $("<div class='actions'>"),
          accept = $("<button class='btn waves-effect waves-light teal' data-accept=" + requestId + ">")
                      .html("<i class='material-icons left'>thumb_up</i> Accept"),
          reject = $("<button class='btn waves-effect waves-light' data-reject=" + requestId + ">")
                      .html("<i class='material-icons left'>thumb_down</i> Reject");

      actions.append(accept).append(reject)
      displayContext.empty().append(title).append(content).append(actions);

      $(".actions").on("click", function (e) {
        var elem = $(e.target),
            notificationFeed = $(".notification-feed"),
            userAction;

        if (elem.data("accept")) {
          sendDbReq({status: "started"}, requestId, elem.data("accept"));
        } else {
          sendDbReq({status: "rejected"}, requestId, elem.data("reject"));
        }
      });
    });

    request.fail(function (msg) {
      return false
    });
  });

}());
