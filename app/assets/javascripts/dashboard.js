$(function() {
  function validateCheckboxes() {
    var plumbing = $("#skillset_Plumbing"),
        carpentry = $("skillset_Carpentry"),
        cleaning = $('#skillset_Cleaning'),
        electrician = $('#skillset_Electrician');

    if ( plumbing.attr('checked') || carpentry.attr('checked') ||
          cleaning.attr('checked') || electrician.attr('checked') ) {
        $('button#choose_skillset').addClass('disabled');
    } else {
      $('button#choose_skillset').removeClass('disabled');
    }
  }
  validateCheckboxes();
});
