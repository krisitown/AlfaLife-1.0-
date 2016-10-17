class Question < ActiveRecord::Base
    has_many :comments
    
    validates :title, presence: true, length: { minumum: 10, maximum: 30}
    validates :content, presence: true, length: {minumum: 100, maximum: 1000}
    validates :user_id, presence: true
end
