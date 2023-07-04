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
    const ingredientId = ingredientField.data('ingredient-id');

    // If the ingredient field has an associated ingredient ID, mark it for destruction
    if (ingredientId) {
      const destroyField = ingredientField.find('.destroy-ingredient-field');
      destroyField.val('1');
      ingredientField.hide();

      // Update the ingredients list by removing the corresponding ingredient
      const ingredientListItem = $(`.ingredient-item[data-ingredient-id="${ingredientId}"]`);
      ingredientListItem.remove();
    } else {
      ingredientField.remove();
    }

    updateIngredientFieldText();
  });

  updateIngredientFieldText();
}

$(document).ready(initializeEditRecipePage);
document.addEventListener('turbolinks:load', initializeEditRecipePage);
