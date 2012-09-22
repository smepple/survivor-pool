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

  before do
    @user = User.create do |u|
              u.email = 'testuser@example.com'
              u.username = 'testuserfoo'
              u.name = 'Test User'
              u.password = 'foobarbaz'
            end
    @league = @user.leagues.create do |l|
                l.name = "The League"
                l.description = "Donec sed odio dui. Maecenas faucibus mollis interdum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec id elit non mi porta gravida at eget metus. Nulla vitae elit libero, a pharetra augue."
                l.code = "1234abcd"
              end
    @membership = @user.memberships.create(league_id: @league.id)
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
    @pick = @user.picks.create do |p|
              p.league_id = @league.id
              p.season_id = @matchup.season_id
              p.week_id = @matchup.week_id
              p.matchup_id = @matchup.id
              p.away = true
              p.home = false
              p.team_name = @matchup.away_team_name
            end
  end

  subject { @pick }

  it { should be_valid }

  it { should respond_to :user }
  it { should respond_to :user }
  it { should respond_to :user }
  it { should respond_to :user }
  it { should respond_to :user }
  it { should respond_to :user }
  it { should respond_to :user }
  it { should respond_to :user }
  it { should respond_to :user }
  it { should respond_to :user }
  it { should respond_to :user }
  it { should respond_to :user }

  describe "when user_id is not present" do
    before { @pick.user_id = nil }
    it { should_not be_valid }
  end

  describe "when league_id is not present" do
    before { @pick.league_id = nil }
    it { should_not be_valid }
  end

  describe "when season_id is not present" do
    before { @pick.season_id = nil }
    it { should_not be_valid }
  end

  describe "when week_id is not present" do
    before { @pick.week_id = nil }
    it { should_not be_valid }
  end

  describe "when matchup_id is not present" do
    before { @pick.matchup_id = nil }
    it { should_not be_valid }
  end

  describe "when team_name is not present" do
    before { @pick.team_name = nil }
    it { should_not be_valid }
  end
end
