class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :firstname, null:false
      t.string :lastname, null:false
      t.string :email, null:false, index: {unique: true}
      t.string :username 
      t.string :password_hash, null:false
    end
  end
end
