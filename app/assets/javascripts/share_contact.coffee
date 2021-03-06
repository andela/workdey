
jQuery ->
  $(".share_contact").on "click", (e) ->
    e.preventDefault()

    swal {
      title: 'share contact with tasker?'
      text: 'Share contact with tasker for easy communication'
      type: 'warning'
      showCancelButton: true
      confirmButtonColor: '#33cc33'
      confirmButtonText: 'Yes, share it'
      cancelButtonText: "No, don't share"
      closeOnConfirm: false
      closeOnCancel: false
    }, (confirmed) =>
      if confirmed
        $.ajax(
          url: $(this).attr("href")
          dataType: "JSON"
          method: "PUT"
          success: =>
            swal 'Success!', 'You have shared your contact with the tasker', 'success'
            $(this).replaceWith("<span class='green-text info_status'> Shared </span>")
        )

      else
        swal 'Cancelled', 'You can share your contact later', 'error'
      return
