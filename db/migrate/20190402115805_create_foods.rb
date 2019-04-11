class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :category
      t.date :default_expiration
      t.string :unit

      t.timestamps
    end
  end
end
