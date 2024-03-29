class LeaguesController < ApplicationController
  before_filter :find_league

  def index
  end

  def new
    @user = User.find(current_user.id)
    @league = @user.leagues.build
  end

  def create
    @user = User.find(current_user.id)
    @league = @user.leagues.create(params[:league])
    if @league.save
      flash[:success] = "Successfully created league"
      redirect_to user_path(@user)
    else
      # flash[:error] = "Oops"
      render 'new'
    end
  end

  def show
    @week = Matchup.where("game_time > ?", Time.now).minimum(:week_id)
    @year = Time.now.strftime('%Y')
    @owner = User.find(@league.user_id)
    @owner_pick = @owner.picks.where("league_id = ? AND season_id = ? AND week_id = ?", 
                                     @league.id, @year, @week).first
    @owner_win_count = @owner.picks.where("league_id = ? AND season_id = ? AND win = ?", 
                                          @league.id, @year, true).count
    @memberships = @league.memberships
  end

  def destroy
  end

private
  def find_league
    @league = League.find(params[:id]) if params[:id]
  end
end
