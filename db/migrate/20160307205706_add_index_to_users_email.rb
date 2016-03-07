class AddIndexToUsersEmail < ActiveRecord::Migration
  def change

  	# This adds an index to the email column of the database for easy scan for duplicates.
  	add_index :users, :email, unique: true
  end
end
