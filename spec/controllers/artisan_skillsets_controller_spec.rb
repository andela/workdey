# frozen_string_literal: true
require "rails_helper"

RSpec.describe ArtisanSkillsetsController, type: :controller do
  let!(:skillsets) { create_list(:skillset, 4) }
  let(:user) { create(:user, user_type: "artisan") }
  let(:artisan_skillset) do
    create(:artisan_skillset, artisan: user, skillset: skillsets.first)
  end
  let(:new_skills) { [skillsets[3].id, skillsets[2].id] }

  before(:each) {  stub_current_user(user) }

  describe "GET #index" do
    let!(:req) { get :index }

    it "renders the index template" do
      expect(response).to render_template(:index)
    end

    it "return a status code of 200" do
      expect(response.status).to eq(200)
    end

    it "assigns skillsets to @skillset" do
      skillsets = Skillset.all
      expect(assigns(:skillsets)).to eq(skillsets)
    end

    it "assigns user skillset ids to @user_skillset" do
      user_skillset = user.artisan_skillsets.map(&:skillset_id)
      expect(assigns(:user_skillset)).to eq(user_skillset)
    end
  end

  describe "PUT #update" do
    let!(:req) { put :update, { skills: new_skills }, format: :js }
    context "when skill ids are present" do
      it "updates skill set" do
        skill_ids = user.artisan_skillsets.map(&:skillset_id)
        expect(skill_ids).to eq(new_skills)
      end

      it "returns json response" do
        expect(parsed_response["message"]).
          to match(/Skills updated successfully./)
        expect(parsed_response["success"]).to be true
      end
    end

    context "when skill ids are blank" do
      let(:new_skills) { [] }

      it "returns a json response" do
        expect(parsed_response["success"]).to be false
        expect(parsed_response["message"]).
          to match(/Please choose at least one skill./)
      end
    end
  end
end
