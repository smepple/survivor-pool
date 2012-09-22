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

class Membership < ActiveRecord::Base
  attr_accessible :league_id, :user_id

  belongs_to :user
  belongs_to :league

  validates_presence_of :league_id, :user_id
end
