$(function(){
  var $ppc = $('.progress-pie-chart'),
    percent = parseInt($ppc.data('percent')),
    deg = 360*percent/100;
    if (percent >= 50 && percent < 81) {
      $ppc.addClass('gt-50');
      $ppc.find('span').addClass('gp-50');
    }
    else if (percent > 81) {
      $ppc.addClass('gt-80');
      $ppc.find('span').addClass('gp-80');
    }
  $('.ppc-progress-fill').css('transform','rotate('+ deg +'deg)');
  $('.ppc-percents span').html(percent+'% Complete');
});
