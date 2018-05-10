require 'rubygems'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require "/Users/eewing/Playpen/RubyPractice/next_final_assessment/app/models/user"
describe User do

  Given(:first_name) {"Ethan"}
  Given(:last_name) {"Ewing"}
  Given(:bio) {"Hello, welcome to my very good page"}
  Given(:email) {"hello@email.com"}
  Given(:encrypted_password) {"password"}
  Given(:username) {"username"}
  Given(:role) {1}
  Given(:avatar) {"avatar.jpg"}

  describe "#initialize" do
    context "takes fn, ln, bio, email, psswd, username, role, and avatar" do
      When (:output) {User.new(first_name, last_name, bio, email, encrypted_password, username, role, avatar)}
      Then {expect(output).to be_a_kind_of(User)}
    end
  end

end
