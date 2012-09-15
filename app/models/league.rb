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

class League < ActiveRecord::Base
  attr_accessible :code, :description, :name

  belongs_to :user
  has_many :memberships, dependent: :destroy

  validates_presence_of :name, :code
  validates_length_of :name, in: 4..20
  validates_length_of :code, in: 4..20
  validates_uniqueness_of :code
end
