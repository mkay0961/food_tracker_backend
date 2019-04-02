class CreateRecipeFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_foods do |t|
      t.integer :recipe_id
      t.integer :food_id
      t.string :amount

      t.timestamps
    end
  end
end
