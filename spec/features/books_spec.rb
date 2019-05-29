require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature 'Books', type: :feature do
  background(:each) do
    user = FactoryBot.create(:user)
    login_as user, scope: :user
  end

  scenario 'user creates a new book' do
    visit root_path
    expect {
      click_link I18n.t(:'helpers.action.book.new')
      fill_in I18n.t(:'activerecord.attributes.book.title'), with: '吾輩は猫である'
      fill_in I18n.t(:'activerecord.attributes.book.memo'), with: '夏目漱石の長編小説であり、処女小説である。'
      fill_in I18n.t(:'activerecord.attributes.book.author'), with: '夏目漱石'
      attach_file I18n.t(:'activerecord.attributes.book.picture'), "#{Rails.root}/spec/factories/book_image.jpg"
      click_button I18n.t(:'helpers.submit.create')

      expect(page).to have_content I18n.t(:'flash.success.create')
      expect(page).to have_content '吾輩は猫である'
    }.to change { Book.count }.by(1)
  end

  scenario 'user show a book' do
    book = FactoryBot.create(:book)
    visit root_path
    click_link I18n.t(:'helpers.action.book.show')

    expect(page).to have_content book.title
  end

  scenario 'user update a book' do
    book = FactoryBot.create(:book)
    visit root_path
    click_link I18n.t(:'helpers.action.book.edit')
    fill_in I18n.t(:'activerecord.attributes.book.title'), with: '吾輩は猫である'
    click_button I18n.t(:'helpers.submit.update')

    expect(page).to have_content I18n.t(:'flash.success.update')
    expect(page).to have_content '吾輩は猫である'
  end

  scenario 'user delete a book' do
    book = FactoryBot.create(:book)
    visit root_path
    expect {
      click_link I18n.t(:'helpers.action.book.destroy')
      page.accept_confirm I18n.t(:'helpers.action.book.destroy_confirm')

      expect(page).to have_content I18n.t(:'flash.success.destroy')
    }.to change { Book.count }.by(-1)
  end
end
