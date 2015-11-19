(function () {
  return smoothScroll.init({
    speed: 1000
  });
}());

(function () {
  var dots = document.querySelectorAll(".dotnavigation ul li");
  return Array.prototype.forEach.call(dots, function (item) {
    return item.addEventListener("click", function () {
      return this.firstElementChild.click();
    });
  });
}());

(function () {
  var scrollItems = $(".dotnavigation ul").children(),
      homeSection = $("#home"),
      stepSection = $("#step"),
      whySection = $("#why-use");

  // Todo: Refactor the code below

  $(window).on("scroll", function () {
    if ($(this).scrollTop() <= homeSection.offset().top) {
      scrollItems.eq(0).addClass("active");
      scrollItems.eq(1).removeClass("active");
      scrollItems.eq(2).removeClass("active");
    } else if ($(this).scrollTop() <= stepSection.offset().top) {
      scrollItems.eq(1).addClass("active");
      scrollItems.eq(0).removeClass("active");
      scrollItems.eq(2).removeClass("active");
    } else if ($(this).scrollTop() <= whySection.offset().top) {
      scrollItems.eq(2).addClass("active");
      scrollItems.eq(0).removeClass("active");
      scrollItems.eq(1).removeClass("active");
    }
  });

}());