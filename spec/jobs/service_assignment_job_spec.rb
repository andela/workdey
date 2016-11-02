require "rails_helper"

RSpec.describe ServiceAssignmentJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later(create(:service)) }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "queues the job" do
    enqueued_jobs = ActiveJob::Base.queue_adapter.enqueued_jobs
    expect { job }.to change(enqueued_jobs, :size).by(1)
  end

  it "is in default queue" do
    expect(ServiceAssignmentJob.new.queue_name).to eq("default")
  end

  describe "job assigning service" do
    let(:service) { FactoryGirl.create(:service) }
    let(:artisan1) { FactoryGirl.create(:user) }
    let(:artisan2) { FactoryGirl.create(:user) }

    it "queues job" do
      create(:rating, rating: 5, user_id: artisan1.id)
      create(:rating, rating: 4, user_id: artisan2.id)
      create(:artisan_skillset,
             skillset_id: service.skillset.id,
             artisan_id: artisan1.id)
      create(:artisan_skillset,
             skillset_id: service.skillset.id,
             artisan_id: artisan2.id)
      ServiceAssignmentJob.perform_later(service)
      expect(ServiceAssignmentJob).to(
        have_been_enqueued.with(service)
      )
    end
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
