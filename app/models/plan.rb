class Plan < ActiveRecord::Base
    validates :to_user, presence: true
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 300 }
end
