import jQuery from 'jquery';

jQuery(document).ready(function($) {
  let index = $('.ingredient-fields').length;

  function updateIngredientFieldText() {
    const ingredientFields = $('.name-input');
    ingredientFields.each(function(i) {
      const currentFieldText = $(this).val();
      if (currentFieldText === '') {
        const fieldPlaceholder = i === 0 ? 'Amount and Name' : 'Add Another Ingredient';
        $(this).attr('placeholder', fieldPlaceholder);
      }
    });
  }

  function updateDeleteButtonsVisibility() {
    const ingredientFields = $('.ingredient-field');
    ingredientFields.each(function(i) {
      const deleteButton = $(this).find('.delete-ingredient');
      if (ingredientFields.length > 1) {
        deleteButton.show();
      } else {
        deleteButton.hide();
      }
    });
  }

  function validateIngredients() {
    const ingredientFields = $('.name-input');
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
  }

  $('#add-ingredient').on('click', function() {
    let ingredientFields = $('.ingredient-fields-template').html().replace(/__INDEX__/g, index++);
    $('.ingredient-fields').append(ingredientFields);
    updateIngredientFieldText();
    updateDeleteButtonsVisibility();
  });

  $('#ingredient-container').on('click', '.delete-ingredient', function() {
    $(this).closest('.ingredient-field').remove();
    updateIngredientFieldText();
    updateDeleteButtonsVisibility();
  });

  $('#recipe-form').on('submit', function() {
    return validateIngredients();
  });

  updateIngredientFieldText();
  updateDeleteButtonsVisibility();

  $('.delete-ingredient').hide();
});
