class BidManagement < ActiveRecord::Base
  belongs_to :bidding
  belongs_to :taskee, class_name: "User"
end
