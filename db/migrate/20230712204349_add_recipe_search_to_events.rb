class AddRecipeSearchToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :recipe_search, :string
  end
end
