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
      flash[:success] = "Successfully created pool"
      redirect_to user_path(@user)
    else
      # flash[:error] = "Oops"
      render 'new'
    end
  end

  def show
    @owner = User.find(@league.user_id)
    @memberships = @league.memberships
  end

  def destroy
  end

private
  def find_league
    @league = League.find(params[:id]) if params[:id]
  end
end
