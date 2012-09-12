class AddNflGameIdToMatchups < ActiveRecord::Migration
  def change
    add_column :matchups, :nfl_game_id, :integer
  end
end
