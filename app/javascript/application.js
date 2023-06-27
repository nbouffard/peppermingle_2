// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import "./resize_recipe_card"
import { initializeRecipes } from './recipes.js';

initializeRecipes();
