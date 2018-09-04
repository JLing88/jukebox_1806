=begin
  As a visitor
  When I visit '/'
  and I can click a link that says "Sign Up to Be a User"
  and I can enter registration details in a form
  and submit that form
  Then I should see a welcome message with my username
  and my user details have been saved in the database.
=end

require 'rails_helper'

describe 'registration and login' do
  describe 'registration' do
    it 'allows a visitor to register' do
      username = 'username'

      visit root_path

      click_on "Sign up to be a new user"

      expect(current_path).to eq(new_user_path)

      fill_in :user_username, with: username
      fill_in :user_password, with: 'password'

      click_on "Create User"

      expect(page).to have_content("Welcome, #{username}")
    end

    it 'blocks registration when username is not unique' do
      username = 'username'
      User.create(username: username, password: "whatever")

      visit root_path

      click_on "Sign up to be a new user"

      expect(current_path).to eq(new_user_path)

      fill_in :user_username, with: username
      fill_in :user_password, with: 'password'

      click_on "Create User"
      expect(page).to_not have_content("Welcome, #{username}")
    end
  end
  describe 'login' do
    it 'allows users to login successfully' do

      user = User.create(username: "greg", password: "greggreggreg")
      visit root_path

      click_on "I already have an account"

      expect(current_path).to eq(login_path)

      fill_in :username, with: user.username
      fill_in :password, with: user.password

      click_on "Log In"

      expect(current_path).to eq(user_path(user))
      expect(page).to have_content("Welcome, #{user.username}")
    end
    it 'blocks users from unsuccessful login' do

      user = User.create(username: "greg", password: "greggreggreg")
      visit root_path

      click_on "I already have an account"

      expect(current_path).to eq(login_path)

      fill_in :username, with: user.username
      fill_in :password, with: "bad password"

      click_on "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to_not have_content("Welcome, #{user.username}")
    end
  end
end
