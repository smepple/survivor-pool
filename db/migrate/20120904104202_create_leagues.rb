class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.text :description
      t.string :code

      t.timestamps
    end
  end
end
