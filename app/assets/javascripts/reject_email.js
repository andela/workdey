function send_email() {
    $.ajax({
        url: ("/reject_applicants"),
        method: "POST",
        data: emailBody()
    }).then(
        function(data) {
            console.log(data)
        },
        function(req, status, error) {
            console.log(error)
        });
};

function emailBody(){
  return {
    body: $("#email-body").val()
  };
};