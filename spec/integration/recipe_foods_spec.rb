require 'rails_helper'

RSpec.describe 'recipes/index', type: :feature do
  describe 'after log in' do
    before(:each) do
      @user = User.create(name: 'Test', email: 'testnw@gmail.com', password: 'test123', confirmed_at: Time.now)
      @recipe1 = Recipe.create(user_id: @user.id, name: 'Burger', preparation_time: 20, cooking_time: 50,
                               description: 'Home style american burger', public: true)
      @recipe2 = Recipe.create(user_id: @user.id, name: 'Pizza', preparation_time: 10, cooking_time: 30,
                               description: 'Test for checking if file works', public: false)

      visit 'users/sign_in'
      fill_in 'Email', with: 'testnw@gmail.com'
      fill_in 'Password', with: 'test123'
      click_on 'Log in'
    end

    it 'displays the information about the recipe' do
      visit '/recipes'
      expect(page).to have_content 'Burger'
      expect(page).to have_content 'Pizza'
      expect(page).to have_content 'Home style american burger'
      expect(page).to have_content 'Test for checking if file works'
    end

    it 'shows buttons to add new recipe' do
      visit '/recipes'
      expect(page).to have_content('Add new Recipe')
    end

    it 'should take you to add new recipe form when clicking on the add new recipe button' do
      visit '/recipes'
      click_on 'Add new Recipe'
      expect(current_path).to eql '/recipes/new'
    end
  end
end
