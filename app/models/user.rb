class User < ApplicationRecord
    has_secure_password
    has_many :posts
    has_many :comments
    has_many :posts, through: :comments

    validates :name, presence: true
    validates :name, uniqueness: true
    validates :email, presence: true
    validates :email, uniqueness: true
    validates :password, presence: true
    # validates :password, length: { minimum: 6 }
end
