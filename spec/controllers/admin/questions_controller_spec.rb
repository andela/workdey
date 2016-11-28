require "rails_helper"

RSpec.describe Admin::QuestionsController, type: :controller do
  subject(:question) { create(:question) }
  before(:each) do
    user = create(:user, user_type: "admin")
    stub_current_user(user)
  end

  describe "GET #index" do
    before(:each) { get :index }

    it "returns a status code of 200" do
      expect(response.status).to eq 200
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "assigns questions" do
      expect(assigns(:questions)).to include(subject)
    end
  end

  describe "GET #new" do
    before(:each) { get :new }

    it "returns a status code of 200" do
      expect(response.status).to eq 200
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

    it "assigns a new question" do
      expect(assigns(:question)).not_to be_nil
    end
  end

  describe "POST #create" do
    context "when parameters are valid" do
      before(:each) do
        post(
          :create,
          Question: Faker::Lorem.sentence,
          question: attributes_for(:question)
        )
      end

      it "creates new question" do
        expect { subject }.to change(Question, :count).by(1)
      end

      it "sets the flash" do
        expect(flash[:notice]).to eq "Question successfully saved."
      end

      it "returns a status code of 302" do
        expect(response.status).to eq 302
      end

      it "redirects to the index view" do
        expect(response).to redirect_to(admin_questions_path)
      end
    end

    context "when parameters are invalid" do
      before(:each) do
        post(
          :create,
          Question: nil,
          question: attributes_for(:question)
        )
      end

      it "does not create new question" do
        expect(assigns[:question].errors[:question]).to include "can't be blank"
      end

      it "renders the new template" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    context "when params are valid" do
      before(:each) { get(:edit, id: question.id) }

      it "returns a status code of 200" do
        expect(response.status).to eq 200
      end

      it "renders the edit template" do
        expect(response).to render_template("edit")
      end

      it "assigns the question to be edited" do
        expect(assigns(:question)).not_to be_nil
      end
    end

    context "when params are invalid" do
      before(:each) { get(:edit, id: -1) }

      it "returns a status code of 302" do
        expect(response.status).to eq 302
      end

      it "redirects to the index view" do
        expect(response).to redirect_to(admin_questions_path)
      end

      it "sets the flash" do
        expect(flash[:notice]).to eq "Question not found."
      end
    end
  end

  describe "PATCH #update" do
    context "when parameters are valid" do
      before(:each) do
        patch(
          :update,
          id: question.id,
          Question: "Updated text",
          question: attributes_for(:question)
        )
      end

      it "sets the flash" do
        expect(flash[:notice]).to eq "Question successfully edited."
      end

      it "returns a status code of 302" do
        expect(response.status).to eq 302
      end

      it "redirects to the index view" do
        expect(response).to redirect_to(admin_questions_path)
      end
    end

    context "when parameters are invalid" do
      before(:each) do
        patch(
          :update,
          id: question.id,
          question: attributes_for(:question)
        )
      end

      it "does not edit question" do
        expect(assigns[:question].errors[:question]).to include "can't be blank"
      end

      it "renders the edit template" do
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    context "when params are valid" do
      before(:each) do
        delete(:destroy, id: question.id)
      end

      it "deletes the question" do
        expect(Question.find_by(id: question.id)).to eq nil
      end

      it "returns a status code of 302" do
        expect(response.status).to eq 302
      end

      it "sets the flash" do
        expect(flash[:notice]).to eq "Question successfully deleted."
      end

      it "redirects to index page" do
        expect(response).to redirect_to admin_questions_path
      end
    end

    context "when params are invalid" do
      before(:each) { delete(:destroy, id: -1) }

      it "returns a status code of 302" do
        expect(response.status).to eq 302
      end

      it "redirects to the index view" do
        expect(response).to redirect_to(admin_questions_path)
      end

      it "sets the flash" do
        expect(flash[:notice]).to eq "Question not found."
      end
    end
  end

  describe "GET #preview" do
    before(:each) { get :preview }

    it "returns a status code of 200" do
      expect(response.status).to eq 200
    end

    it "renders the preview template" do
      expect(response).to render_template("preview")
    end

    it "assigns questions" do
      expect(assigns(:questions)).to include(subject)
    end
  end
end
