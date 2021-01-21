class Post < ApplicationRecord
    belongs_to :user
    belongs_to :community
    has_many :comments
    has_many :users, through: :comments
    # accepts_nested_attributes_for :community

    validates :title, presence: true
    validates :title, uniqueness: true
    validates :title, length: { maximum: 150 }
    validates :url, uniqueness: true, allow_blank: true, allow_nil: true

    # adding Active Record scope methods
    scope :self_posts, -> { where('url == ?', "" )}
    scope :linked_posts, -> { where('url != ?', "" )}

    def self.search(query)
        if query.present?
          where('TITLE like ?', "%#{query}%")
        else
          self.all
        end
    end
    
end
