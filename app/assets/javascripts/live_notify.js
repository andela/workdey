(function () {
  var dispatcher = new WebSocketRails("localhost:3000/websocket");

  dispatcher.on_open = function (data) {
    var notificationIndicator = $(".notification-badge span"),
        notificationWrapper = $(".dashboard-navlinks"),
        notificationElem = $("<li class='notification-badge'>"),
        notificationElemChild = $("<span>");

    console.log("Hello websocket");

     if (location.pathname === "/dashboard/notifications") {
        console.log("Websocket open");
        $(".notification-badge").remove();
    }

    dispatcher.bind("new_task", function (msg) {
      if (msg === 1) {
        notificationElemChild.text(msg);
        notificationWrapper.prepend( notificationElem.append(notificationElemChild) );
        console.log("Websocket bind")
      } else if (msg > 1) {
        notificationIndicator.text(msg)
      } else {
        return;
      }
    });
  };

}());