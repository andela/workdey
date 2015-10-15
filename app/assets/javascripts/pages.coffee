# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

( () -> smoothScroll.init speed: 1000 )()

(() ->
  dots = document.querySelectorAll(".dotnavigation ul li")
  Array.prototype.forEach.call(dots, (item) ->
    item.addEventListener("click", () -> 
      this.firstElementChild.click()
      )
    ))()
