(function () {
  if (typeof Firebase !== "undefined") {
    var dbRef = new Firebase("https://torrid-inferno-5507.firebaseio.com/");

    dbRef.on("value", function (snapshot) {
      var main = {
        model: {
          score: 0,
          questions: snapshot.val(),
          total: snapshot.val().length,
          createOptions: function (opt) {
            var frag = document.createDocumentFragment(),
                pElem,
                radio,
                label;

            opt.forEach(function (item, index, arr) {
              pElem = document.createElement("p");
              radio = document.createElement("input");
              label = document.createElement("label");

              radio.type = "radio";
              radio.value = item;
              radio.name = "quiz-opt";
              radio.id = "radio " + (index + 1);

              label.setAttribute("for", radio.id);
              label.textContent = radio.value;

              pElem.appendChild(radio);
              pElem.appendChild(label);

              frag.appendChild(pElem);
            });

            return frag;
          },
          generateView: function () {
            if (main.model.questions.length === 0) {
              this.endQuiz();
              return;
            }
            var currentQ = main.model.questions.shift();

            main.view.questionHolder.textContent = currentQ.question;
            main.view.optionsWrap.appendChild(main.model.createOptions(currentQ.options));

            main.view.explanation.textContent = currentQ.reason;

            main.controller.validator(currentQ.answer);
          },
          clearOptions: function () {
            var optionsWrap = main.view.optionsWrap;

            for (var i = optionsWrap.children.length - 1; i >= 0; i--) {
              optionsWrap.removeChild(optionsWrap.children[i]);
            };

            this.generateView();
          },
          initializeApp: function () {
            var quizInfo = document.querySelector(".quiz-info"),
                startQuiz = document.querySelector(".start-quiz");
            startQuiz.addEventListener("click", function () {
              quizInfo.style.opacity = 0;
              main.view.progressWrap.style.opacity = 1;

              window.setTimeout(function () {
                quizInfo.style.display = "none";
              }, 1000);

              window.setTimeout(function () {
                main.model.generateView();
                main.view.nextBtn.style.opacity = "1";
                main.view.nextBtn.setAttribute("disabled", true);
              }, 1000);

            }, false);
          },
          endQuiz: function () {
            var score = main.model.score,
                total = main.model.total,
                link = document.createElement("a"),
                guidlines = document.createElement("button");

            guidlines.className = "btn guidelines";
            guidlines.innerHTML = "<i class='material-icons right'>forward</i>Show Guidelines";

            link.className = "btn";
            link.href = "/quiz";

            main.view.optionsWrap.appendChild(link);
            main.view.optionsWrap.style.textAlign = "center";

            main.view.nextBtn.style.display = "none";

            if (score === total) {
              main.view.questionHolder.textContent = "Congratulations! You aced the quiz";
              link.textContent = "Proceed";
              link.setAttribute("data-method", "post");
              link.href += "?aced=true"
            } else {
              main.view.questionHolder.textContent = "You got " + (total - score) + " wrong";
              link.innerHTML = "<i class='material-icons left'>replay</i>Retake Quiz";
              main.view.optionsWrap.appendChild(guidlines);
              main.controller.showGuidelines();
            }
          }
        },
        view: {
          nextBtn: document.querySelector(".next"),
          remark: document.querySelector(".remark"),
          explanation: document.querySelector(".exp"),
          optionsWrap: document.querySelector(".options"),
          progressWrap: document.querySelector(".progress"),
          questionHolder: document.querySelector(".question"),
          quizSection: document.querySelector(".quiz-section"),
          explanationWrapper: document.querySelector(".answer-explanation")
        },
        controller: {
          updateProgress: function () {
            var progress = main.view.progressWrap.firstElementChild,
                total = main.model.total,
                percentage = (100 / total),
                currentWidth = parseFloat(progress.style.width);

            progress.style.width = (currentWidth + percentage) + "%";
          },
          showGuidelines: function () {
            var guidelineBtn = document.querySelector(".guidelines"),
                guidelines = document.querySelector(".taskee-guidelines"),
                quizSection = main.view.quizSection;

            guidelineBtn.addEventListener("click", function () {
              this.setAttribute("disabled", true);
              quizSection.style.transform = "translateX(-200px)";

              guidelines.style.opacity = 1;
              guidelines.style.zIndex = 1;
            }, false);
          },
          showRemark: function () {
            var explanation = main.view.explanationWrapper,
                quizSection = main.view.quizSection;

            quizSection.style.transform = "translateX(200px)";

            window.setTimeout(function () {
              explanation.style.opacity = 1;
            }, 1000);

          },
          hideRemark: function () {
            var explanation = main.view.explanationWrapper,
                quizSection = main.view.quizSection;

            explanation.style.opacity = 0;
            window.setTimeout(function () {
              quizSection.style.transform = "none";
            }, 1000);
          },
          validator: function (answer) {
            var options = main.view.optionsWrap,
                remark = main.view.remark,
                answer = answer.replace(/\s{2,}/g, " "),
                selected,
                clickCount = 0;

            main.view.nextBtn.innerHTML = "<i class='material-icons right'>forward</i>Submit";

            options.addEventListener("change", function (e) {
              main.view.nextBtn.removeAttribute("disabled");
              selected = e.target;
            }, false);

            main.view.nextBtn.addEventListener("click", function () {
              clickCount += 1
              if (clickCount === 1) {
                main.controller.showRemark();
                this.innerHTML = "<i class='material-icons right'>forward</i>Next";

                for (var i = options.children.length - 1; i >= 0; i--) {
                  options.children[i].firstElementChild.setAttribute("disabled", true);
                };

                if (selected.value.replace(/\s{2,}/g, " ") === answer) {
                  main.model.score += 1;
                  remark.textContent = "Correct!";
                  selected.nextElementSibling.style.color = "#558b2f";
                } else {
                  remark.textContent = "Bummer, you got that wrong";
                  selected.nextElementSibling.style.color = "#d50000";
                }
              } else if (clickCount === 2) {
                main.controller.hideRemark();
                main.controller.updateProgress();
                this.setAttribute("disabled", true);
                main.model.clearOptions();
              }
            }, false);
          }
        },
        init: function () {
          this.model.initializeApp();
        }
      };
    main.init();
    });
  }
}());
