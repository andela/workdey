var group = $(".group");

group.on("click", ".fa", function () {
  var allPrevElements;
  $("input[name=rating]").removeProp("checked");
  $(this).next().prop("checked", true);
  $(this).removeClass("fa-star-o");
  $(this).addClass("fa-star");

  allPrevElements = $(this).closest(".group").prevAll(".group");
  allNextElements = $(this).closest(".group").nextAll(".group");

  for (var i = 0; i < allPrevElements.length; i ++) {
    allPrevElements[i].children[0].classList.remove("fa-star-o");
    allPrevElements[i].children[0].classList.add("fa-star");
  }

  for (var i = 0; i < allNextElements.length; i ++) {
    allNextElements[i].children[0].classList.remove("fa-star");
    allNextElements[i].children[0].classList.add("fa-star-o");
  }
}); 