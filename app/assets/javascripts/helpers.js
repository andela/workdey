(function () {
  // Dashboard dropdown
   $(".dropdown").dropdown({
      inDuration: 300,
      outDuration: 225,
      constrain_width: false, // Does not change width of dropdown to that of the activator
      hover: false,
      gutter: 0, // Spacing from edge
      belowOrigin: true, // Displays dropdown below the button
      alignment: "left" // Displays dropdown with edge aligned to the left of button
    }
  );
}());
