# frozen_string_literal: true
class PostmanWorker
  include Sidekiq::Worker

  def perform(info, _count)
    info = JSON.load(info)
    ContactMailer.contact_details(info["name"], info["email"],
                                  info["subject"], info["message"]).deliver_now
  end
end
