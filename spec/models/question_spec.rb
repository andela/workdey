require "rails_helper"

describe Question do
  it { should validate_presence_of(:question) }
end
