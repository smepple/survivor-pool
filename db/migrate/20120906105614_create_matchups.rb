class CreateMatchups < ActiveRecord::Migration
  def change
    create_table :matchups do |t|
      t.integer :season_id
      t.integer :week_id
      t.datetime :game_time
      t.string :away_team_name
      t.string :away_team_logo_url
      t.string :home_team_name
      t.string :home_team_logo_url
      t.integer :team_score_away
      t.integer :team_score_home

      t.timestamps
    end
  end
end
