class User < ActiveRecord::Base
  belongs_to :department
  belongs_to :position
end
