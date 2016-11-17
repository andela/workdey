require "rails_helper"

RSpec.describe ServiceRating, type: :model do
  before(:each) do
    @tasker = create(:user)
    @artisan = create(:user, user_type: "artisan")
    @service = create(:service, tasker: @tasker, artisan: @artisan)
    @service_second = create(:service, tasker: @tasker, artisan: @artisan)
  end

  it { is_expected.to belong_to(:service) }

  it { is_expected.to validate_presence_of :rating }
  it do
    is_expected.to validate_inclusion_of(:rating).
      in_array([1, 2, 3, 4, 5])
  end

  it { is_expected.to validate_presence_of :private_feedback }
  it do
    is_expected.to validate_length_of(:private_feedback).is_at_least(3).
      with_message("Too short. The minimum length is 3 characters.")
  end

  it { is_expected.to validate_presence_of :public_feedback }
  it do
    is_expected.to validate_length_of(:public_feedback).is_at_least(3).
      with_message("Too short. The minimum length is 3 characters.")
  end

  it { is_expected.to validate_presence_of :category }

  describe ".get_ratings" do
    it "returns ratings of an artisan" do
      create :service_rating, service: @service

      artisan_ratings = ServiceRating.get_ratings(@artisan)

      expect(artisan_ratings[0].service.artisan.id).to eq @artisan.id
    end
  end

  describe ".compute_average_rating" do
    it "returns the average rating of an artisan" do
      create :service_rating, rating: 3, service: @service
      create :service_rating, rating: 4, service: @service_second

      artisan_average_rating = ServiceRating.compute_average_rating(@artisan)

      expect(artisan_average_rating).to eq 3.5
    end
  end

  describe ".get_artisan_rating" do
    it "returns the rating of an artisan" do
      create :service_rating, rating: 3, service: @service

      artisan_rating = ServiceRating.get_artisan_rating(@artisan)

      expect(artisan_rating[0].rating).to eq 3
    end
  end

  describe ".get_tasker_rating" do
    it "returns the rating of a tasker" do
      create(
        :service_rating,
        rating: 5,
        category: ServiceRating.categories[:artisan_to_tasker],
        service: @service
      )

      tasker_rating = ServiceRating.get_tasker_rating(@tasker)

      expect(tasker_rating[0].rating).to eq 5
    end
  end

  describe ".get_artisan_average_rating" do
    it "returns the average rating of an artisan" do
      create :service_rating, rating: 2, service: @service
      create :service_rating, rating: 4, service: @service_second

      artisan_average = ServiceRating.get_artisan_average_rating(@artisan)

      expect(artisan_average).to eq 3
    end
  end

  describe ".get_tasker_average_rating" do
    it "returns the average rating of a tasker" do
      create(
        :service_rating,
        rating: 3,
        category: ServiceRating.categories[:artisan_to_tasker],
        service: @service
      )

      create(
        :service_rating,
        rating: 2,
        category: ServiceRating.categories[:artisan_to_tasker],
        service: @service
      )

      tasker_rating = ServiceRating.get_tasker_average_rating(@tasker)

      expect(tasker_rating).to eq 2.5
    end
  end

  describe "#tasker_to_artisan?" do
    it "returns the rating type tasker_to_artisan" do
      @service_rating = create :service_rating, rating: 3, service: @service

      expect(@service_rating.tasker_to_artisan?).to eq true
    end
  end

  describe "#artisan_to_tasker?" do
    it "returns the rating type artisan_to_tasker" do
      @service_rating = create(
        :service_rating,
        rating: 2,
        category: ServiceRating.categories[:artisan_to_tasker],
        service: @service
      )

      expect(@service_rating.artisan_to_tasker?).to eq true
    end
  end
end
