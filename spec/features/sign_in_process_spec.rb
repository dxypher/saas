require 'rails_helper'

RSpec.feature "SignInProcesses", type: :feature do
  it "requires the user log in and successfully logs in" do
    password = '123456789'
    u = FactoryBot.create(:user, { password: password, password_confirmation: password })

    visit root_path

    within "#new_user" do
      fill_in "user_email",	with: u.email
      fill_in "user_password",	with: password
    end

    click_button "Sign In"

    expect(current_path).to eql(root_path)
  end

  it "fails on an invalid user" do
    visit root_path

    within "#new_user" do
      fill_in "user_email",	with: 'test'
      fill_in "user_password",	with: 'password'
    end

    click_button 'Sign In'
    expect(current_path).to eql(new_user_session_path)
  end
end
