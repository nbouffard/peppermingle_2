class CreateIngredientJoinTables < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredient_join_tables do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
