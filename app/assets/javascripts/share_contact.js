function sharecontact() {
    swal({
        title: "Do you want to share your contact?",
        text: "yur contact will be shared with this tasker",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Share with tasker",
        cancelButtonText: "No don't share",
        closeOnConfirm: false
    }, function (isConfirm) {
        if (!isConfirm) return;
        $.ajax({
            url: "scriptDelete.php",
            type: "PUT",
            data: {
                shared: true
            },
            dataType: "html",
            success: function () {
                swal("Done!", "Contact shared with tasker", "success");
            },
            error: function (xhr, ajaxOptions, thrownError) {
                swal("Error!!", "Please try again", "error");
            }
        });
    });
}
