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
    hiddenAmountInput.name = 'recipe[ingredient_join_tables_attributes][' + index + '][ingredient_attributes][amount]';
    hiddenAmountInput.value = amount;
    listItem.appendChild(hiddenAmountInput);

    var hiddenNameInput = document.createElement('input');
    hiddenNameInput.type = 'hidden';
    hiddenNameInput.name = 'recipe[ingredient_join_tables_attributes][' + index + '][ingredient_attributes][name]';
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
