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
#

require 'spec_helper'

describe User do

  before do
    @user = User.create do |u|
              u.email = 'testuser@example.com'
              u.username = 'testuserfoo'
              u.name = 'Test User'
              u.password = 'foobarbaz'
            end
  end

  subject { @user }

  it { should be_valid }

  it { should respond_to :email }
  it { should respond_to :encrypted_password }
  it { should respond_to :reset_password_token }
  it { should respond_to :reset_password_sent_at }
  it { should respond_to :remember_created_at }
  it { should respond_to :sign_in_count }
  it { should respond_to :current_sign_in_at }
  it { should respond_to :last_sign_in_at }
  it { should respond_to :current_sign_in_ip }
  it { should respond_to :last_sign_in_ip }
  it { should respond_to :confirmation_token }
  it { should respond_to :confirmed_at }
  it { should respond_to :confirmation_sent_at }
  it { should respond_to :unconfirmed_email }
  it { should respond_to :failed_attempts }
  it { should respond_to :unlock_token }
  it { should respond_to :locked_at }
  it { should respond_to :authentication_token }
  it { should respond_to :provider }
  it { should respond_to :uid }
  it { should respond_to :username }
  it { should respond_to :name }
  it { should respond_to :leagues }
  it { should respond_to :memberships }
  it { should respond_to :picks }
  it { should respond_to :password_required? }
end
