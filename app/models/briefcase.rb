class Briefcase < ActiveRecord::Base
  belongs_to :user
  has_many :briefcases_stocks
  has_many :stocks, through: :briefcases_stocks

  accepts_nested_attributes_for :briefcases_stocks, allow_destroy: true

  validates_presence_of :name
end
