jQuery(document).ready(function($) {
  let index = $('.edit-ingredient-fields').length;

  function updateIngredientFieldText() {
    const ingredientFields = $('.edit-name-input');
    ingredientFields.each(function(i) {
      const currentFieldText = $(this).val();
      if (currentFieldText === '') {
        const fieldPlaceholder = i === 0 ? 'Amount and Name' : 'Add Another Ingredient';
        $(this).attr('placeholder', fieldPlaceholder);
      }
    });
  }

  $(document).on('click', '#edit-add-ingredient', function() {
    let ingredientFields = $('.edit-ingredient-fields-template').html().replace(/__INDEX__/g, index++);
    $('.edit-ingredient-fields').append(ingredientFields);
    updateIngredientFieldText();
  });

  $(document).on('click', '.edit-delete-ingredient', function() {
    const ingredientField = $(this).closest('.edit-ingredient-field');
    const ingredientInput = ingredientField.find('.edit-name-input');
    const destroyField = ingredientField.find('.destroy-ingredient-field');

    ingredientInput.val(''); // Clear the ingredient field value
    destroyField.val('true'); // Mark the ingredient for destruction
    ingredientField.hide(); // Hide the ingredient field from the form

    updateIngredientFieldText();
  });

  $(document).on('submit', '#recipe-form', function() {
    const ingredientFields = $('.edit-name-input');
    let isEmpty = true;
    ingredientFields.each(function() {
      if ($(this).val() !== '') {
        isEmpty = false;
        return false;
      }
    });

    if (isEmpty) {
      alert('Ingredients cannot be empty');
      return false;
    }

    return true;
  });

  updateIngredientFieldText();
});

document.addEventListener('turbolinks:load', function() {
  initializeEditRecipePage();
});
