# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string(255)
#  uid                    :string(255)
#  username               :string(255)
#  name                   :string(255)
#  avatar_url             :string(255)
#

class User < ActiveRecord::Base
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  devise :database_authenticatable, :token_authenticatable,
         :registerable, :recoverable, :rememberable, :trackable, 
         :validatable, :lockable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, 
                  :remember_me, :username, :name, :login, :avatar_url

  has_many :leagues, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :picks

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = user.generate_password
      unless auth.info.nickname.blank?
        user.username = auth.info.nickname
      else
        user.username = "#{auth.info.firstname.downcase}_#{auth.info.lastname.downcase}"
      end
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  # def self.new_with_session(params, session)
  #   if session["devise.user_attributes"]
  #     new(session["devise.user_attributes"], without_protection: true) do |user|
  #       user.attributes = params
  #       user.valid?
  #     end
  #   else
  #     super
  #   end
  # end

  def password_required?
    super && provider.blank?
  end

  # def update_with_password(params, *options)
  #   if encrypted_password.blank?
  #     update_attributes(params, *options)
  #   else
  #     super
  #   end
  # end

  def generate_password
    password = SecureRandom.urlsafe_base64
    # self.password_confirmation = self.password
  end
end
