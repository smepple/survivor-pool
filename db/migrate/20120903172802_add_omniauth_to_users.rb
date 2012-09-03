class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :omniauth_provider, :string
    add_column :users, :omniauth_uid, :string
  end
end
