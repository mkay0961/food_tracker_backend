class CreateUserFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :user_foods do |t|
      t.integer :user_id
      t.integer :food_id
      t.boolean :active
      t.string :amount
      t.decimal :price
      t.date :expiration_date
      t.date :throw_away
      t.boolean :expired

      t.timestamps
    end
  end
end
