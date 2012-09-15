class PicksController < ApplicationController
  def index
  end

  def new
    @weeks = 1..17
    @current_week = Matchup.where("game_time > ?", Time.now).minimum(:week_id)
    @league = League.find(params[:league_id])
    @matchups = Matchup.where(week_id: params[:week_id])
    @pick = Pick.new(params[:pick])
  end

  def create
    @league = League.find(params[:league_id])
    @pick = current_user.picks.create(params[:pick])

    if @pick.save
      flash[:success] = "Successfully picked the #{@pick.team_name}!"
      redirect_to new_league_pick_path(@league, week_id: params[:pick][:week_id])
    else
      flash[:error] = "Couldn't make that pick"
      redirect_to new_league_pick_path(@league, week_id: params[:pick][:week_id])
    end
  end

  def show
  end

  def edit
  end
end
