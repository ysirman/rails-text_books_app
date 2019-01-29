class Book < ApplicationRecord
    validates :title, presence: true
    validates :memo, presence: true
    mount_uploader :picture, PictureUploader
end
