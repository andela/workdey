require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:skillsets) }
  it { is_expected.to have_many(:reviews) }
  it { is_expected.to have_many(:tasks).through(:skillsets) }
  it do
    is_expected.to have_many(:tasks_given).class_name("TaskManagement").
      with_foreign_key(:taskee_id)
  end
  it do
    is_expected.to have_many(:tasks_created).class_name("TaskManagement").
      with_foreign_key(:tasker_id)
  end
  describe ".before_save" do
    it "converts all emails to lowercase" do
      user = create(:user, email: "MAYOWA.PITAN@ANDEla.COM")
      expect(user.email).to eql "mayowa.pitan@andela.com"
    end
  end

  describe ".before_create" do
    it "generates a confirm token before it creates" do
      user = build(:user)
      expect(user.confirm_token).to be nil
      user.save
      expect(user.confirm_token).not_to be nil
    end
  end

  describe ".validate_firstname" do
    it "must have a last name" do
      expect(build(:user, firstname: nil).save).to eql false
    end
    it "must have a proper length" do
      expect(build(:user, firstname: "A").save).to eql false
    end
    it "must have the right characters" do
      expect(build(:user, firstname: "Mayor1").save).to eql false
    end
  end

  describe ".validate_lastname" do
    it "must have a last name" do
      expect(build(:user, lastname: nil).save).to eql false
    end
    it "must have a proper length" do
      expect(build(:user, lastname: "B").save).to eql false
    end
    it "must have the right characters" do
      expect(build(:user, lastname: "2face").save).to eql false
    end
  end

  describe ".validate_email" do
    it "must have an email" do
      expect(build(:user, email: nil).save).to eql false
    end
    it "must be unique" do
      create(:user)
      user2 = User.new(firstname: "Ikem", lastname: "Okonkwo",
                       email: "mayowa.pitan@andela.com",
                       password: "ruby_tabernacle")
      expect(user2.save).to eql false
    end
    it "must not contain odd characters" do
      expect(build(:user, email: "mayowa.pitan()@.andela.com").
        save).to eql false
    end
  end
  describe ".validate_password" do
    it "ensures a password is supplied, it cannot be nil" do
      expect(build(:user, password: nil).save).to eql false
    end
    it "must have the correct length" do
      expect(build(:user, password: "andela").save).to be false
    end
  end
  pending ".first_or_create_from_oauth" do
    it "" do
    end
  end
  describe ".confirm_user" do
    it "can confirm a user's token" do
      user = create(:user)
      expect(user.confirmed).to be false
      User.confirm_user(user.confirm_token)
      expect(user.reload.confirmed).to be true
    end
    describe "#oath_user" do
      it "should return true if present" do
        user = build(:user, oauth_id: "487584789")
        expect(user.send(:oauth_user?)).to be true
      end
      it "should return false if absent" do
        user = build(:user)
        expect(user.send(:oauth_user?)).to be false
      end
    end
    describe ".get_user_address" do
      it "should return the user's address" do
        create(:user, city: "Lagos", street_address: "55, Moleye Str")
        expect(User.get_user_address("mayowa.pitan@andela.com").first).
          to eql ["Lagos", "55, Moleye Str"]
      end
    end
    describe ".get_taskees_by_task_name" do
      it "can return users by their task name" do
        user1 = create(:user)
        create(:user_with_tasks, email: "ikem.okonkwo@andela.com")
        create(:user_with_tasks, email: "bukola.makinwa@andela.com")
        expect(User.get_taskees_by_task_name("trainer").count).to eql 2
        expect(User.get_taskees_by_task_name("trainer")).not_to include user1
      end
    end
  end
end
