// app/javascript/controllers/recipe_search_controller.js

import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['input', 'results', 'recipeId', 'selectedRecipe'];

  async search() {
    const term = this.inputTarget.value.trim();
    console.log('Search term:', term); // Add console log statement here
    if (term.length >= 2) {
      const response = await fetch(`/recipes/search_ajax?term=${term}`);
      const html = await response.text();
      this.resultsTarget.innerHTML = html;
    } else {
      this.resultsTarget.innerHTML = '';
    }
  }
  selectRecipe(e) {
    const selectedRecipeTitle = e.target.textContent;
    const selectedRecipeId = e.target.dataset.recipeId;
    console.log('Selected Recipe:', selectedRecipeTitle, selectedRecipeId);
    this.recipeIdTarget.value = selectedRecipeId;

    if(selectedRecipeTitle) {
      this.selectedRecipeTarget.value = selectedRecipeTitle;
      this.selectedRecipeTarget.style.display = 'block'; // Show the input field
    } else {
      this.selectedRecipeTarget.style.display = 'none'; // Hide the input field
    }
  }

}
