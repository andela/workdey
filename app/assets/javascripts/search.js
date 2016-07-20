$(document).ready(function() {
  //Hide Search field
  $( ".search-i" ).click(function() {
    $( ".search-bar" ).toggle("slide", { direction: "right" }, 500);
  });
});
