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

require 'spec_helper'

describe Pick do
  pending "add some examples to (or delete) #{__FILE__}"
end
