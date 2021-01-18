class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    validates :reply, length: { minimum: 1 }
end
