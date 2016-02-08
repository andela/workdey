(function () {
  var input = $("#notifications_enabled");

  if ( input.attr("checked") === "checked" ) {
    input.prop("checked", true);
  } else {
    input.prop("checked", false);
  }

  input.on("change", function () {
    $(this).prop("checked") ? $(this).val("on") : $(this).val("off");
  });
}());