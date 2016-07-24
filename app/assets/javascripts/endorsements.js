$(function() {
  var $toastErrorMessage = $('<span> Please choose at least one skill</span>');

  $('#new_endorsement').validate({
    rules: {
      "reference[skillsets][]": {
        required: true
      },
      "relationship": {
        required: true
      },
      "recommendation": {
        required: true
      }
    },
    messages: {
      "reference[skillsets][]": "Please choose at least one skill",
      "recommendation": "Please add your recommendation."
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
