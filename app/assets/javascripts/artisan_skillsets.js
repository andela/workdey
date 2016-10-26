$('button#update_skillset').click(function(e) {
  e.preventDefault();

  var checkedSkills = [],
      toastErrorMessage = $('<span>Oops, something went wrong.<br> Please try again.</span>');

  $('input.skillset[type=checkbox]:checked').each(function() {
    checkedSkills.push($(this).val());
  });

  $.ajax({
    method: 'PUT',
    url: '/artisan_skillsets',
    data: { skills: checkedSkills },
    dataType: 'json',
    success: function(data) {
      console.log(data.message)
      Materialize.toast(data.message, 4000);
    },
    error: function(error) {
      Materialize.toast("Please try again.", 4000);
    }
  })
});
