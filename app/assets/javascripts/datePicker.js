$(document).ready(function(){
  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 15
  });
  // $('select').material_select();
  $('#timepicker').pickatime({
    autoclose: false
    // twelvehour: false
  });
});
