# frozen_string_literal: true
class BidManagement < ActiveRecord::Base
  belongs_to :bidding
  belongs_to :artisan, class_name: "User"
end
