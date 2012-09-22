class RegistrationsController < Devise::RegistrationsController
  
  def update
    @user = User.find(current_user.id)
    email_changed = @user.email != params[:user][:email]
    # password_changed = !params[:user][:password].empty?
    name_changed = @user.name != params[:user][:name]
    username_changed = @user.username != params[:user][:username]

    successfully_updated = if email_changed or name_changed or username_changed
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      sign_in @user, :bypass => true
      redirect_to :back
    else
      render "edit"
    end
  end
end