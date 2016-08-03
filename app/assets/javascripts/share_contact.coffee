
jQuery ->
  $("#share_contact").on "click", (e) ->
    e.preventDefault()

    swal {
      title: 'share contact with tasker?'
      text: 'Share contact with tasker for easy communication'
      type: 'warning'
      showCancelButton: true
      confirmButtonColor: '#DD6B55'
      confirmButtonText: 'Yes, share it'
      cancelButtonText: 'No, dont share'
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
            # TODO: Also remove the item from the page
            $("#share_contact").hide()
        )

      else
        swal 'Cancelled', 'You can share your contact later', 'error'
      return
