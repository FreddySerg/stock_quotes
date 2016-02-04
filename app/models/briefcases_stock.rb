class BriefcasesStock < ActiveRecord::Base
  belongs_to :briefcase
  belongs_to :stock
end
