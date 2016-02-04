class Stock < ActiveRecord::Base
  has_many :briefcases_stocks
  has_many :briefcases, through: :briefcases_stocks
end
