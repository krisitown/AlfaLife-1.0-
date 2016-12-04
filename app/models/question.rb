class Question < ActiveRecord::Base
    has_many :comments
    
    validates :title, presence: true, length: { minimum: 10, maximum: 70}
    validates :content, presence: true, length: {minimum: 100, maximum: 3000}
    validates :user_id, presence: true
    validates :category, presence: true
end
