function initializeEditRecipePage() {
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

  updateIngredientFieldText();
}

jQuery(document).ready(function($) {
  initializeEditRecipePage();
});

document.addEventListener('turbolinks:load', initializeEditRecipePage);
