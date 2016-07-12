$(document).ready(function(){
  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 15
  });
  // $('#task_skillset_id').material_select();
  $('#timepicker').pickatime({
    autoclose: false
    // twelvehour: false
  });
});
