export function initializeRecipes() {
  document.addEventListener('DOMContentLoaded', function() {
    var addIngredientBtn = document.getElementById('add-ingredient');
    var ingredientsPreview = document.getElementById('ingredients-preview');
    var index = 0;

    if (!addIngredientBtn || !ingredientsPreview) {
      console.log("Could not find required elements");
      return;
    }

    addIngredientBtn.addEventListener('click', function() {
      var amountInput = document.querySelector('.amount-input');
      var nameInput = document.querySelector('.name-input');

      if (!amountInput || !nameInput) {
        console.log("Could not find required elements");
        return;
      }

      var amount = amountInput.value;
      var name = nameInput.value;

      if (amount && name) {
        var listItem = document.createElement('li');
        listItem.textContent = amount + ' ' + name;

        var hiddenAmountInput = document.createElement('input');
        hiddenAmountInput.type = 'hidden';
        hiddenAmountInput.name = 'recipe[ingredients_attributes]['+index+'][amount]';
        hiddenAmountInput.value = amount;
        listItem.appendChild(hiddenAmountInput);

        var hiddenNameInput = document.createElement('input');
        hiddenNameInput.type = 'hidden';
        hiddenNameInput.name = 'recipe[ingredients_attributes]['+index+'][name]';
        hiddenNameInput.value = name;
        listItem.appendChild(hiddenNameInput);

        ingredientsPreview.appendChild(listItem);
        amountInput.value = '';
        nameInput.value = '';

        index++;
      } else {
        console.log("Amount or Name input is empty");
      }
    });
  });
}

initializeRecipes();
