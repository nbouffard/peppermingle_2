// Entry point for the build script in your package.json
import './add_jquery'
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import "./controllers"
import "bootstrap"
import "./resize_recipe_card"
import './add_ingredient'
import './edit_ingredient'
import _flatpickr from "flatpickr";
import 'flatpickr/dist/flatpickr.min.css';
