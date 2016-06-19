// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$('#reviewers').on('change', function() {
  if (this.value) {
    $.get( "/review/tasks/" + this.value, function( data ) {
      $("#tasks").html(data);
    });
  }
 // or $(this).val()
  });