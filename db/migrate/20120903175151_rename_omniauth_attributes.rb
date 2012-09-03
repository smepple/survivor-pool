class RenameOmniauthAttributes < ActiveRecord::Migration
  def change
    rename_column :users, :omniauth_provider, :provider
    rename_column :users, :omniauth_uid, :uid
  end
end
