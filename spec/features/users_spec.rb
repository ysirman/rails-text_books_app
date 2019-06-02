require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  scenario 'sign up' do
    visit root_path
    click_link I18n.t(:'devise.shared.links.sign_up')
    fill_in I18n.t(:'activerecord.attributes.user.name'), with: 'fuga taro'
    fill_in I18n.t(:'activerecord.attributes.user.email'), with: 'fuga@fuga.fuga'
    fill_in I18n.t(:'activerecord.attributes.user.password'), with: 'fuga password'
    fill_in I18n.t(:'activerecord.attributes.user.password_confirmation'), with: 'fuga password'
    attach_file I18n.t(:'activerecord.attributes.user.avatar'), "#{Rails.root}/spec/factories/user_image.jpg"
    click_button I18n.t(:'devise.shared.links.sign_up')

    expect(page).to have_content I18n.t(:'devise.registrations.signed_up')
    expect(page).to have_content 'fuga taro'
  end

  scenario 'login' do
    user = FactoryBot.create(:user)
    visit root_path
    fill_in I18n.t(:'activerecord.attributes.user.email'), with: user.email
    fill_in I18n.t(:'activerecord.attributes.user.password'), with: user.password
    click_button I18n.t(:'devise.shared.links.sign_in')

    expect(page).to have_content I18n.t(:'books.index.title')
    expect(page).to have_content user.name
  end

  scenario 'update profile' do
    user = FactoryBot.create(:user)
    login_as user, scope: :user
    visit root_path
    click_link user.name
    click_link I18n.t(:'helpers.action.user.edit')
    fill_in I18n.t(:'activerecord.attributes.user.name'), with: 'another name'
    fill_in I18n.t(:'activerecord.attributes.user.current_password'), with: user.password
    click_button I18n.t(:'devise.registrations.edit.update')

    expect(page).to have_content I18n.t(:'devise.registrations.updated')
    expect(page).to have_content 'another name'
  end

  scenario 'delete user' do
    user = FactoryBot.create(:user)
    login_as user, scope: :user
    visit root_path
    expect {
      click_link user.name
      click_link I18n.t(:'helpers.action.user.edit')
      click_button I18n.t(:'devise.registrations.edit.cancel_my_account')
      page.accept_confirm
      expect(current_path).to eq new_user_session_path
    }.to change { User.count }.by(-1)
  end

  scenario 'login with Omniauth' do
    expect {
      OmniAuth.config.mock_auth[:github] = nil
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
        provider: 'github',
        uid: '123545',
        info: {
          nickname: 'mock',
          email: 'mock@mock.com'
        },
      })
      visit root_path
      click_on I18n.t(:'devise.shared.links.sign_in_with_provider', provider: "GitHub")
      
      expect(page).to have_content I18n.t(:'devise.omniauth_callbacks.success', kind: "github")
    }.to change { User.count }.by(1)
  end
end
