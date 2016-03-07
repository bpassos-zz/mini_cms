class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      # This command creates tow columns "created_at" and "updated_at" which
      # are time stamps that automatically record when a given user is created and updated.
      t.timestamps null: false
    end
  end
end
