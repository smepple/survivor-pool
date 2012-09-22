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

  before do
    @matchup = Matchup.create do |m|
                 m.season_id = 2012
                 m.week_id = 1
                 m.game_time = '2012-09-22 11:38:00'
                 m.away_team_name = "piggers"
                 m.away_team_logo_url = "www.google.com"
                 m.home_team_name = "hoggers"
                 m.home_team_logo_url = "www.google.com"
                 m.nfl_game_id = 2012092201
               end
  end

  subject { @matchup }

  it { should be_valid }

  it { should respond_to :season_id }
  it { should respond_to :week_id }
  it { should respond_to :game_time }
  it { should respond_to :away_team_name }
  it { should respond_to :away_team_logo_url }
  it { should respond_to :home_team_name }
  it { should respond_to :home_team_logo_url }
  it { should respond_to :team_score_away }
  it { should respond_to :team_score_home }
  it { should respond_to :nfl_game_id }
  it { should respond_to :picks }
  it { should respond_to :mark_dups }
  it { should respond_to :remove_dups }

  describe "when season_id is not present" do
    before { @matchup.season_id = nil }
    it { should_not be_valid }
  end

  describe "when week_id is not present" do
    before { @matchup.week_id = nil }
    it { should_not be_valid }
  end

  describe "when game_time is not present" do
    before { @matchup.game_time = nil }
    it { should_not be_valid }
  end

  describe "when away_team_name is not present" do
    before { @matchup.away_team_name = nil }
    it { should_not be_valid }
  end

  describe "when away_team_logo_url is not present" do
    before { @matchup.away_team_logo_url = nil }
    it { should_not be_valid }
  end

  describe "when home_team_name is not present" do
    before { @matchup.home_team_name = nil }
    it { should_not be_valid }
  end

  describe "when home_team_logo_url is not present" do
    before { @matchup.home_team_logo_url = nil }
    it { should_not be_valid }
  end

  describe "when nfl_game_id is not present" do
    before { @matchup.nfl_game_id = nil }
    it { should_not be_valid }
  end
end
