require "shoulda/matchers"
require "rails_helper"

RSpec.describe User, type: :model do

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  let(:user){FactoryBot.create :user}

  describe "associations" do
    it "has many products" do
      is_expected.to have_many(:products).dependent :destroy
    end

    it "has many suggests" do
      is_expected.to have_many(:suggests).dependent :destroy
    end

    it "has many orders" do
      is_expected.to have_many(:orders).dependent :destroy
    end

    it "has many ratings" do
      is_expected.to have_many(:ratings).dependent :destroy
    end
  end

  context "validates" do
    describe "name" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_length_of(:name).is_at_most 100}
    end

    describe "email" do
      it {is_expected.to validate_presence_of :email}
      it {is_expected.to validate_length_of(:email).is_at_most 255}
      it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
      it "should be invalid format" do
        format_emails = %w[user@foo,com user_at_foo.org example.user@foo.
          foo@bar_baz.com foo@bar+baz.com]
        format_emails.each do |format_email|
          if user.email == format_email
            expect(user).not_to be_valid
          end
        end
      end
    end

    describe "phone" do
      it {is_expected.to validate_presence_of :phone}
      it {is_expected.to validate_numericality_of :phone}
      it {is_expected.to validate_length_of(:phone).is_at_least 10}
      it {is_expected.to validate_length_of(:phone).is_at_most 11}
    end

    describe "password" do
      it {is_expected.to validate_presence_of :password}
      it {is_expected.to validate_length_of(:password).is_at_least 6}
    end
  end
end
