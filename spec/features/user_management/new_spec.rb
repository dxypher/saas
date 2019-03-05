require 'rails_helper'

RSpec.feature "New", type: :feature do
  login_user

  it "should be able to visit the user index and see at least one user" do

    visit account_users_path

    expect(current_path).to eql(account_users_path)
    expect(page).to have_content("#{@user.name}")
  end

  context "click add new user" do

    it "should click new and go to new page" do
      visit account_users_path
      click_on("Add User")
      expect(current_path).to eql(new_account_user_path)
    end

    context "and on the new page" do
      it "adds the new user successfully" do
        visit account_users_path
        click_on("Add User")

        within "#new_user" do
          fill_in "user_name", with: 'Test'
          fill_in "user_email", with: 'test@test.com'
          select('User', :from => 'user_role')
        end

        click_button("Add User")
        expect(current_path).to eql(account_users_path)
      end

      it "and fails to add the new user successfully" do
        visit account_users_path
        click_on("Add User")

        within "#new_user" do
          fill_in "user_name", with: 'Test'
          fill_in "user_email", with: ''
          select('User', :from => 'user_role')
        end

        click_button("Add User")
        expect(current_path).to eql(account_users_path)
      end
    end
  end
end