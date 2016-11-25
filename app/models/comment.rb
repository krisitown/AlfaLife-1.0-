class Comment < ActiveRecord::Base
    has_many :comments
    
    validates :content, presence: true, length: { minimum: 4, maximum: 5000 }
end
