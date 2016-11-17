// Todo: Refactor the code below

(function () {
  var app = {
    view: {
      parentWrapper: document.querySelector(".intro"),
      artisanBtn: document.querySelector(".btn-artisan"),
      taskerBtn: document.querySelector(".btn-tasker"),
      taskerGuidelinesWrapper: document.querySelector(".tasker-guidelines"),
      artisanGuidelinesWrapper: document.querySelector(".artisan-guidelines")
    },
    controller: {
      showArtisanGuidelines: function () {
        var parentWrapper = app.view.parentWrapper,
            taskerWrapper = app.view.taskerGuidelinesWrapper,
            artisanWrapper = app.view.artisanGuidelinesWrapper;

        parentWrapper.style.transform = "translateX(-200px)";

        taskerWrapper.style.opacity = "0";
        taskerWrapper.style.zIndex = "-1";

        window.setTimeout(function () {
          artisanWrapper.style.opacity = "1";
          artisanWrapper.style.zIndex = "1";
        }, 1000);
      },
      showTaskerGuidelines: function () {
        var parentWrapper = app.view.parentWrapper,
            taskerWrapper = app.view.taskerGuidelinesWrapper,
            artisanWrapper = app.view.artisanGuidelinesWrapper;

        parentWrapper.style.transform = "translateX(200px)";

        artisanWrapper.style.opacity = "0";
        artisanWrapper.style.zIndex = "-1";

        window.setTimeout(function () {
          taskerWrapper.style.opacity = "1";
          taskerWrapper.style.zIndex = "1";
        }, 1000);

      },
      handleClickEvents: function () {
        var artisanBtn = app.view.artisanBtn,
            taskerBtn = app.view.taskerBtn;

        artisanBtn.addEventListener("click", function () {
          this.setAttribute("disabled", true);
          taskerBtn.removeAttribute("disabled");
          app.controller.showArtisanGuidelines();
        });

        taskerBtn.addEventListener("click", function () {
          this.setAttribute("disabled", true);
          artisanBtn.removeAttribute("disabled");
          app.controller.showTaskerGuidelines();
        });
      }
    },
    init: function () {
      this.controller.handleClickEvents();
    }
  };

  try {
    app.init();
  } catch(ex) {
    return false;
  }
}());
