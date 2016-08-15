(function () {
  var notifyBtn = $('.notify-btn')

  notifyBtn.click(function (event) {
    event.preventDefault()
    var notificationId = $(this).data('id'),
      taskUrl = $(this).attr('href')

    updateNotification(notificationId).done(function () {
      window.location.href = taskUrl
    })

    function updateNotification (notificationId) {
      return $.ajax({
        url: '/dashboard/notifications/' + notificationId,
        method: 'PUT'
      })
    }
  })
}())
