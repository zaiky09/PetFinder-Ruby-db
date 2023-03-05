class CreatePets < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.string :name, null:false
      t.string :breed, null:false 
      t.string :image_src 
      t.string :description 
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
