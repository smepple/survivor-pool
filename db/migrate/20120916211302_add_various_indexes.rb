class AddVariousIndexes < ActiveRecord::Migration
  def change
    add_index :users, :username, unique: true
    add_index :leagues, :code, unique: true
    add_index :leagues, :user_id
    add_index :memberships, :user_id
    add_index :memberships, :league_id
    add_index :memberships, [:user_id, :league_id], unique: true
    add_index :picks, :user_id
    add_index :picks, :league_id
    add_index :picks, :matchup_id
    add_index :picks, [:user_id, :league_id, :matchup_id], unique: true
  end
end
