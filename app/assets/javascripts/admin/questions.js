// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  $('.modal-trigger').leanModal({
    dismissible: false
  });
});

var option_number = 0

function addInputBox(text) {
  //$('#question_options').append("<br />");
  $('#question_options').append("<div id='" + option_number + "' class='input-field row'></div>");
  $('#' + option_number).append("<input value='" + text + "' type='text' name='question[options][]' class='col s9 m9 l9'></input>");
  $('#' + option_number).append(
    "<a class='waves-effect waves-light btn red small col s3 m3 l3' onclick='removeInputBox(" + option_number + ")'><i class='material-icons left'>cancel</i>Remove</a>"
  );
  option_number++;
}

function removeInputBox(id) {
  $('#' + id).remove();
  option_number--;
}

$('#add_option').click(function (event) {
  event.preventDefault(); // Prevent link from following its href
});
