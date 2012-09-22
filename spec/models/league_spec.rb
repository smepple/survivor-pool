# == Schema Information
#
# Table name: leagues
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  code        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

require 'spec_helper'

describe League do

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
  end

  subject { @league }

  it { should be_valid }

  it { should respond_to :user }
  it { should respond_to :user_id }
  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :code }
  it { should respond_to :memberships }
  it { should respond_to :picks }

  describe "when name is not present" do
    before { @league.name = nil }
    it { should_not be_valid }
  end

  describe "when code is not present" do
    before { @league.code = nil }
    it { should_not be_valid }
  end

  describe "when name is too short" do
    before { @league.name = "foo" }
    it { should_not be_valid }
  end

  describe "when code is too short" do
    before { @league.code = "foo" }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @league.name = "a"*21 }
    it { should_not be_valid }
  end

  describe "when code is too long" do
    before { @league.code = "a"*21 }
    it { should_not be_valid }
  end

  describe "when code is not unique" do
    before { @league_with_same_code = @league.dup }
    subject { @league_with_same_code }
    it { should_not be_valid }
  end
end
