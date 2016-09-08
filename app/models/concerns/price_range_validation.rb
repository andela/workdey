module PriceRangeValidation
  extend ActiveSupport::Concern

  included do
    validate :price_range_validation
  end

  private

  def price_range_validation
    if price_range.empty?
      errors[:price_range] = "Please enter atleast the minimum price"
    else
      check_price_range
    end
  end

  def check_price_range
    min_price, max_price = price_range.map(&:to_i)
    value_error_message = "Prices must be greater than $2000"
    comparison_error_message = "Minimum price must be less than the maximum"

    errors[:price_range] = value_error_message if min_price < 2000
    if max_price.positive?
      errors[:price_range] = value_error_message if max_price < 2000
      errors[:price_range] = comparison_error_message if min_price > max_price
    end
  end
end
