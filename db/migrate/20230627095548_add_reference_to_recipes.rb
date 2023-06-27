class AddReferenceToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :user
  end
end
