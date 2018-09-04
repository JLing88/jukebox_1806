require 'rails_helper'

describe 'logged in user can log out' do
  describe 'they click Log out from the navbar' do
    it 'logs user out of the application' do
      user = User.create(username: "greg", password: "greggreggreg")
      visit login_path

      click_on "I already have an account"

      expect(current_path).to eq(login_path)

      fill_in :username, with: user.username
      fill_in :password, with: user.password

      click_on "Log In"
      expect(page).to_not have_content("I already have an account")
      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(@current_user).to eq(nil)
    end
  end
end
