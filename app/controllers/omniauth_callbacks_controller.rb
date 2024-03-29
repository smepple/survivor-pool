class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.now["notice"] = "Signed in!"
      sign_in user
      redirect_to user_path(user)
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_path
    end
  end
  alias_method :facebook, :all
end
