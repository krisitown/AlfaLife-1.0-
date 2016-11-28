class User < ActiveRecord::Base
    has_secure_password
    has_many :questions
    has_many :comments

    validates :name, presence: true, length: { minimum: 3, maximum: 40 }
    validates :email, presence: true, length: { minimum: 9, maximum: 40}
end
