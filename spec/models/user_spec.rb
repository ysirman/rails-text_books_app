require 'rails_helper'

RSpec.describe User, type: :model do
  # 名前、メール、パスワードがあれば有効な状態であること
  it 'is valid with a name, email, and password' do
    user = User.new(
      name: 'hoge taro',
      email: 'hoge@hoge.hoge',
      password: 'hoge password'
    )
    expect(user).to be_valid
  end
  
  # 名前がなければ無効な状態であること
  it 'is invalid without a name' do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include(I18n.t :'errors.messages.blank')
  end
  
  # メールがなければ無効な状態であること
  it 'is invalid without an email address' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include(I18n.t :'errors.messages.blank')
  end
  
  # パスワードがなければ無効な状態であること
  it 'is invalid without a password' do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include(I18n.t :'errors.messages.blank')
  end
  
  # 重複したメールアドレスなら無効な状態であること
  it 'is invalid with a duplicate email address' do
    duplicate_email = 'tester@example.com'
    User.create(
      name: 'hoge',
      email: duplicate_email,
      password: 'hogege'
    )
    user = User.new(
      name: 'fuga',
      email: duplicate_email,
      password: 'fugaga'
    )
    user.valid?
    expect(user.errors[:email]).to include(I18n.t :'errors.messages.taken')
  end
end
