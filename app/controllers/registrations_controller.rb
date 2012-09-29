class RegistrationsController < Devise::RegistrationsController
  
  def update
    @user = User.find(current_user.id)
    avatar_url_changed = @user.avatar_url != params[:user][:avatar_url]
    email_changed = @user.email != params[:user][:email]
    # password_changed = !params[:user][:password].empty?
    name_changed = @user.name != params[:user][:name]
    username_changed = @user.username != params[:user][:username]

    successfully_updated = if email_changed or name_changed or username_changed or avatar_url_changed
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      sign_in @user, :bypass => true
      flash[:success] = "Cheers! Your profile was updated."
      redirect_to edit_user_registration_path(current_user)
    else
      render "edit"
    end
  end
end