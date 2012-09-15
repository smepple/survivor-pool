class MatchupsController < ApplicationController
  def index
    @matchups = Matchup.all
  end

  def show
  end
end
