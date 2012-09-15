# == Schema Information
#
# Table name: picks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  league_id  :integer
#  season_id  :integer
#  week_id    :integer
#  matchup_id :integer
#  away       :boolean
#  home       :boolean
#  team_name  :string(255)
#  win        :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Pick < ActiveRecord::Base
  attr_accessible :away, :home, :league_id, 
                  :matchup_id, :season_id,
                  :team_name, :user_id, :week_id, 
                  :win

  belongs_to :user
  belongs_to :league
  belongs_to :matchup

  validates_presence_of :user_id, :league_id, :season_id, 
                        :week_id, :matchup_id, :team_name
end
