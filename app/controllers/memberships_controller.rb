class MembershipsController < ApplicationController
  before_filter :find_user

  def new
    @membership = @user.memberships.new
  end

  def create
    @code = params[:code]
    @league = League.find_by_code(@code)

    if @league
      @membership = @user.memberships.create! do |m|
                      m.league_id = @league.id
                    end
      if @membership.save
        flash[:success] = "Successfully joined #{@league.name}"
        redirect_to user_path(@user)
      else
        flash[:error] = "There was a problem"
        redirect_to new_membership_path
      end
    else
      flash[:error] = "No league was found matching code: #{@code}"
      redirect_to new_membership_path
    end
  end

  private
  def find_user
    @user = current_user
  end
end
