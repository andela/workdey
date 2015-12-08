// Todo: Refactor the code below

(function () {
  var app = {
    view: {
      parentWrapper: document.querySelector(".intro"),
      taskeeBtn: document.querySelector(".btn-taskee"),
      taskerBtn: document.querySelector(".btn-tasker"),
      taskerGuidelinesWrapper: document.querySelector(".tasker-guidelines"),
      taskeeGuidelinesWrapper: document.querySelector(".taskee-guidelines")
    },
    controller: {
      showTaskeeGuidelines: function () {
        var parentWrapper = app.view.parentWrapper,
            taskerWrapper = app.view.taskerGuidelinesWrapper,
            taskeeWrapper = app.view.taskeeGuidelinesWrapper;
        
        parentWrapper.style.transform = "translateX(-200px)";

        taskerWrapper.style.opacity = "0";
        taskerWrapper.style.zIndex = "-1";

        window.setTimeout(function () {
          taskeeWrapper.style.opacity = "1";
          taskeeWrapper.style.zIndex = "1";
        }, 1000);
      },
      showTaskerGuidelines: function () {
        var parentWrapper = app.view.parentWrapper,
            taskerWrapper = app.view.taskerGuidelinesWrapper,
            taskeeWrapper = app.view.taskeeGuidelinesWrapper;

        parentWrapper.style.transform = "translateX(200px)";

        taskeeWrapper.style.opacity = "0";
        taskeeWrapper.style.zIndex = "-1";

        window.setTimeout(function () {
          taskerWrapper.style.opacity = "1";
          taskerWrapper.style.zIndex = "1";
        }, 1000);
        
      },
      handleClickEvents: function () {
        var taskeeBtn = app.view.taskeeBtn,
            taskerBtn = app.view.taskerBtn;

        taskeeBtn.addEventListener("click", function () {
          this.setAttribute("disabled", true);
          taskerBtn.removeAttribute("disabled");
          app.controller.showTaskeeGuidelines();
        });

        taskerBtn.addEventListener("click", function () {
          this.setAttribute("disabled", true);
          taskeeBtn.removeAttribute("disabled");
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