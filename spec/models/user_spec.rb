require "rails_helper"
RSpec.describe User, type: :model do
  it { is_expected.to have_many(:skillsets).through(:taskee_skillsets) }

  it do
    is_expected.to have_many(:taskee_skillsets).with_foreign_key(:taskee_id)
  end

  it { is_expected.to have_many(:reviews) }


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
      user = create(:user)
      user2 = User.new(firstname: "Ikem", lastname: "Okonkwo",
                       email: user.email,
                       password: "ruby_tabernacle")
      expect(user2.save).to eql false
    end
    it "must not contain odd characters" do
      expect(build(:user, email: "mayowa.pitan()@.andela.com").save).
        to eql false
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

  describe ".confirm_user" do
    it "can confirm a user's token" do
      user = create(:user)
      expect(user.confirmed).to be false
      User.confirm_user(user.confirm_token)
      expect(user.reload.confirmed).to be true
    end
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
      street_address = Faker::Address.street_name
      city = Faker::Address.city
      user = create(:user, city: city, street_address: street_address)
      expect(User.get_user_address(user.email).first).
        to eql [city, street_address]
    end
  end

  describe ".get_taskee_by_skillset_name" do
    it "return users by their skillset name" do
      skillset = create(:skillset)
      user = create(:user, user_attr.merge(user_type: "taskee"))
      user.skillsets << skillset
      create_list(:skillset, 2)
      expect(User.get_taskees_by_skillset(skillset.name).count).to eq 1
    end
  end

  describe "#taskee" do
    it "returns true if the user is a taskee" do
      user = create(:user, user_type: "taskee")
      expect(user.taskee?).to eq true
    end
    it "returns false for a tasker" do
      user = create(:user, user_type: "tasker")
      expect(user.taskee?).to eq false
    end
  end

  describe ".first_or_create_from_oauth" do
    context "when a user is not found" do
      before do
        @user_attributes = OmniAuth.config.mock_auth[:facebook]
      end
      it "will create a new user if no user is found" do
        expect { User.first_or_create_from_oauth(@user_attributes) }.
          to change { User.count }.by(1)
      end
      it "the new user should be confirmed" do
        User.first_or_create_from_oauth(@user_attributes)
        expect(User.first.confirmed).to eql true
      end
    end

    context "when the user is already in the database" do
      before do
        @user_attributes = OmniAuth.config.mock_auth[:facebook]
        @user = User.first_or_create_from_oauth(@user_attributes)
      end
      it "user count should remain one if a user is available" do
        expect { User.first_or_create_from_oauth(@user_attributes) }.
          to change { User.count }.by(0)
      end
      it "will return the user if found" do
        expect(User.first_or_create_from_oauth(@user_attributes)).to eql @user
      end
    end
  end

  describe "#fullname" do
    it "should concatenate the first and last names of users" do
      user = build(:user)
      expect(user).to be_truthy
      expect(user.fullname).to eql user.firstname + " " + user.lastname
    end
  end
end
