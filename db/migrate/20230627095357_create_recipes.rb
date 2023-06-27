class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.string :meal_type
      t.string :season
      t.string :cuisine
      t.integer :prep_time
      t.integer :total_time
      t.string :difficulty
      t.integer :servings
      t.string :dietary_requirements
      t.text :directions

      t.timestamps
    end
  end
end
