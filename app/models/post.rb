class Post < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many :users, through: :comments

    validates :title, presence: true
    validates :title, length: { maximum: 150 }
    # if :url != ""
    #     validates :url, uniqueness: true
    # end

    def self.search(query)
        if query.present?
          where('TITLE like ?', "%#{query}%")
        else
          self.all
        end
    end
    
end
