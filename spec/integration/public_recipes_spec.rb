require 'rails_helper'

RSpec.describe 'public_recipes/index.html.erb', type: :feature do
  describe 'after log in' do
    before(:each) do
      @user = User.create(name: 'Test ', email: 'test@gmail.com', password: 'Test123', confirmed_at: Time.now)
      @recipe1 = Recipe.create(user_id: @user.id, name: 'Burger', preparation_time: 20, cooking_time: 50,
                               description: 'Home style american burger', public: true)
      @recipe2 = Recipe.create(user_id: @user.id, name: 'Pizza', preparation_time: 10, cooking_time: 30,
                               description: 'Classic Italian pizza', public: false)

      visit 'users/sign_in'
      fill_in 'Email', with: 'test@gmail.com'
      fill_in 'Password', with: 'Test123'
      click_on 'Log in'
    end

    it 'shows a list of public recipes' do
      visit '/public_recipes'
      expect(page).to have_content 'Public Recipes'
      expect(page).to have_content 'Burger'
      expect(page).to have_content 'Total Food of item'
      expect(page).to have_content 'Total Price'
    end

    it 'does not allow users to delete a recipe' do
      visit '/public_recipes'
      expect(page).to_not have_content 'Delete'
    end

    it 'has a link to recipe show page' do
      visit '/public_recipes'
      click_on 'Burger'
      expect(current_path).to eql "/recipes/#{@recipe1.id}"
    end
  end
end
