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

require 'spec_helper'

describe Matchup do
  pending "add some examples to (or delete) #{__FILE__}"
end
