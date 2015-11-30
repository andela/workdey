(function () {
  try {
    var dismissibleWrapper = document.querySelector(".flash-mail"),
        closeButton = document.querySelector(".close-flash");

    closeButton.addEventListener("click", function () {
      dismissibleWrapper.classList.add("hidden");
    }, false);
  } catch(ex) {
    return false;
  }
}());