# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  league_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Membership do

  before do
    @user = User.create do |u|
              u.email = 'testuser@example.com'
              u.username = 'testuserfoo'
              u.name = 'Test User'
              u.password = 'foobarbaz'
            end
    @league = @user.leagues.create do |l|
                l.name = "The League"
                l.description = "Donec sed odio dui. Maecenas faucibus mollis interdum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec id elit non mi porta gravida at eget metus. Nulla vitae elit libero, a pharetra augue."
                l.code = "1234abcd"
              end
    @membership = @user.memberships.create(league_id: @league.id)
  end

  subject { @membership }

  it { should be_valid }

  it { should respond_to :user }
  it { should respond_to :user_id }
  it { should respond_to :league }
  it { should respond_to :league_id }

  describe "when user_id is not present" do
    before { @membership.user_id = nil }
    it { should_not be_valid }
  end

  describe "when league_id is not present" do
    before { @membership.league_id = nil }
    it { should_not be_valid }
  end
end
