$(function() {
  var $toastErrorMessage = $('<span>Please choose atleast one skill</span>');

  $('#new_reference').validate({
    rules: {
      "reference[firstname]": {
        required: true
      },
      "reference[skillsets][]": {
        required: true
      }
    },
    messages: {
      "reference[skillsets][]": "Please choose atleast one skill"
    },
    errorClass: 'invalid',
    errorPlacement: function (error, element) {
      if ( element.is("input[type='checkbox']") ) {
        Materialize.toast($toastErrorMessage, 4000);
      } else {
        element.next("label").attr("data-error", error.contents().text());
      }
    },
  });
});
