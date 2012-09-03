class User < ActiveRecord::Base
  devise :database_authenticatable, :token_authenticatable, 
         :registerable, :recoverable, :rememberable, :trackable, 
         :validatable, :confirmable, :lockable, :timeoutable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :username

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      unless auth.info.nickname.blank?
        user.username = auth.info.nickname
      else
        user.username = "#{auth.info.firstname.downcase}_#{auth.info.lastname.downcase}"
      end
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
