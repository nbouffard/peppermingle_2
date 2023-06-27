// JavaScript to resize card height depending on text length

document.addEventListener("DOMContentLoaded", function() {
  var recipeCardContent = document.querySelector(".recipe-card-content");
  var recipeCardContainer = document.querySelector(".recipe-card-container");
  var notesContainer = document.querySelector(".notes-container");
  var notesContent = document.querySelector(".notes-content");

  adjustContainerHeight(recipeCardContent, recipeCardContainer);
  adjustContainerHeight(notesContent, notesContainer);

  window.addEventListener("resize", function() {
    adjustContainerHeight(recipeCardContent, recipeCardContainer);
    adjustContainerHeight(notesContent, notesContainer);
  });

  function adjustContainerHeight(content, container) {
    var extraHeight = 15; // Additional 15 pixels

    if (content && container) { // Check if both elements exist
      var contentHeight = content.offsetHeight;
      container.style.height = contentHeight + extraHeight + "px";
    }
  }
});
