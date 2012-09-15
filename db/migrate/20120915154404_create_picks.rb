class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :user_id
      t.integer :league_id
      t.integer :season_id
      t.integer :week_id
      t.integer :matchup_id
      t.boolean :away
      t.boolean :home
      t.string :team_name
      t.boolean :win

      t.timestamps
    end
  end
end
