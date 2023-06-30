document.addEventListener("DOMContentLoaded", function() {
  var addIngredientBtn = document.getElementById('add-ingredient');
  var ingredientsPreview = document.getElementById('ingredients-preview');
  var nameInput = document.querySelector('.name-input');
  var index = 0;
  var ingredientLabel = document.querySelector('.ingredient-label');

  if (addIngredientBtn && nameInput && ingredientLabel) {
    addIngredientBtn.addEventListener('click', addIngredient);
    nameInput.addEventListener('keydown', function(event) {
      if (event.key === 'Enter') {
        addIngredient();
        event.preventDefault();
      }
    });

    function addIngredient() {
      var name = nameInput.value.trim();

      if (name) {
        var listItem = document.createElement('li');

        var nameSpan = document.createElement('span');
        nameSpan.textContent = name;

        var hiddenNameInput = document.createElement('input');
        hiddenNameInput.type = 'hidden';
        hiddenNameInput.name = 'recipe[ingredient_join_tables_attributes][' + index + '][ingredient_attributes][name]';
        hiddenNameInput.value = name;

        var removeLink = document.createElement('a');
        removeLink.href = "#";
        removeLink.textContent = "Remove";
        removeLink.className = "remove-link";
        removeLink.addEventListener('click', function(e) {
          e.preventDefault();
          listItem.remove();
        });

        listItem.appendChild(nameSpan);
        listItem.appendChild(hiddenNameInput);
        listItem.appendChild(removeLink);

        ingredientsPreview.appendChild(listItem);
        nameInput.value = '';
        index++;

        if (index === 1) {
          changeLabelWithTransition('Add more ingredients');
        }
      } else {
        console.log("Name input is empty");
      }
    }

    function changeLabelWithTransition(newLabel) {
      ingredientLabel.classList.add('transition-label');

      setTimeout(function() {
        ingredientLabel.textContent = newLabel;
        ingredientLabel.classList.remove('transition-label');
      }, 500);
    }
  } else {
    console.log("Could not find required elements");
  }
});
