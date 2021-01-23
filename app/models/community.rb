class Community < ApplicationRecord
    has_many :posts
    has_many :users, through: :posts
    
    validates :category, uniqueness: true
    validates :info, presence: true
end
