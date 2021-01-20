class Community < ApplicationRecord
    has_many :posts
    validates :category, uniqueness: true
end
