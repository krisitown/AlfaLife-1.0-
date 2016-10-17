class User < ActiveRecord::Base
    has_secure_password
    has_many :questions
    has_many :comments

    validates :name, length: { minumum: 5, maximum: 30 }
    validates :email, presence: true, length: { minumum: 9, maximum: 30}
end
