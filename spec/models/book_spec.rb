require 'rails_helper'

RSpec.describe Book, type: :model do
  # タイトル、メモがあれば有効な状態であること
  it 'is valid with a title and memo' do
    book = Book.new(
      title: '吾輩は猫である',
      memo: '夏目漱石の長編小説であり、処女小説である。'
    )
    expect(book).to be_valid
  end
  
  # タイトルがなければ無効な状態であること
  it 'is invalid without a title' do
    book = Book.new(title: nil)
    book.valid?
    expect(book.errors[:title]).to include(I18n.t :'errors.messages.blank')
  end
  
  # メモがなければ無効な状態であること
  it 'is invalid without a memo' do
    book = Book.new(memo: nil)
    book.valid?
    expect(book.errors[:memo]).to include(I18n.t :'errors.messages.blank')
  end
end
