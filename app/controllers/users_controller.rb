class UsersController < ApplicationController
  # before_filter :find_user

  def index
    find_user
  end

  def show
    find_user
    @leagues = @user.leagues
    @memberships = @user.memberships
  end

private
  def find_user
    @user = User.find(params[:id]) if params[:id]
  end
end
