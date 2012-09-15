# == Schema Information
#
# Table name: matchups
#
#  id                 :integer          not null, primary key
#  season_id          :integer
#  week_id            :integer
#  game_time          :datetime
#  away_team_name     :string(255)
#  away_team_logo_url :string(255)
#  home_team_name     :string(255)
#  home_team_logo_url :string(255)
#  team_score_away    :integer
#  team_score_home    :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  nfl_game_id        :integer
#

class Matchup < ActiveRecord::Base

  validates_presence_of :season_id, :week_id, :game_time, 
                        :away_team_name, :away_team_logo_url, 
                        :home_team_name, :home_team_logo_url, 
                        :nfl_game_id

  before_create :mark_dups
  after_create :remove_dups

  def mark_dups
    dup = Matchup.find_by_nfl_game_id(self.nfl_game_id)
    self.nfl_game_id = 1 if dup
  end

  def remove_dups
    dup = Matchup.find_by_nfl_game_id(1)
    dup.destroy if dup
  end
end
