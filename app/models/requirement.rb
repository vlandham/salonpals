class Requirement < ActiveRecord::Base
  belongs_to :post
  belongs_to :skill
end
