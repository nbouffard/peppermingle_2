jQuery(document).ready(function($) {
  let index = $('.edit-ingredient-field').length;

  function updateIngredientFieldText() {
    const ingredientFields = $('.edit-ingredient-field');
    ingredientFields.each(function(i) {
      const currentField = $(this).find('.edit-name-input');
      const fieldPlaceholder = i === 0 ? 'Amount and Name' : 'Add Another Ingredient';
      currentField.attr('placeholder', fieldPlaceholder);
    });
  }

  function initializeEditRecipePage() {
    $('#edit-add-ingredient').on('click', function() {
      let ingredientFieldsTemplate = $('.edit-ingredient-fields-template').html();
      let ingredientFields = ingredientFieldsTemplate.replace(/__INDEX__/g, index++);
      $('.edit-ingredient-fields').append(ingredientFields);
      updateIngredientFieldText();
    });

    $(document).on('click', '.edit-delete-ingredient', function() {
      const ingredientField = $(this).closest('.edit-ingredient-field');
      const ingredientInput = ingredientField.find('.edit-name-input');
      const destroyField = ingredientField.find('.destroy-ingredient-field');
      const ingredientValue = ingredientInput.val();

      ingredientInput.val('');
      destroyField.val('1');
      ingredientField.hide();

      updateIngredientFieldText();
    });

    updateIngredientFieldText();
  }

  $(document).ready(initializeEditRecipePage);
  $(document).on('turbolinks:load', initializeEditRecipePage);
});
