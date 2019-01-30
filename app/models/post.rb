class Post < ApplicationRecord
    belongs_to :user
    validates :user_id, presence: true
    #model validations
    #validates :content, presence: true
    mount_uploader :picture, PictureUploader

    validate :picture_size
    #custom validations
    def picture_size
        if picture.size > 5.megabytes
            errors.add(:picture, "should be less than 5MB")
        end
    end
end
