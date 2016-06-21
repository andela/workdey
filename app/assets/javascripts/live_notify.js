(function () {
  var dispatcher = new WebSocketRails(host_name());

  function host_name () {
    if ( location.port.length === 0 ) {
      return location.hostname + '/websocket';
    } else {
      return location.hostname + ':' + location.port + '/websocket';
    }
  };

  dispatcher.on_open = function (data) {
    var notificationIndicator = $(".notification-badge span"),
        notificationWrapper = $(".dashboard-navlinks"),
        notificationElem = $("<li class='notification-badge'>"),
        notificationElemChild = $("<span>");

    if (location.pathname === "/dashboard/notifications") {
      $(".notification-badge").remove();
    }

    dispatcher.bind("new_task", showNotificationCount);

    function showNotificationCount (msg) {
      if (msg >= 1) {
        notificationElemChild.text(msg);
        notificationWrapper.prepend( notificationElem.append(notificationElemChild) );
      } else {
        return;
      }
    };
  };
}())
