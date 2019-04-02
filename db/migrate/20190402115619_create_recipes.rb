class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :description
      t.string :instructions
      t.string :catagory

      t.timestamps
    end
  end
end
