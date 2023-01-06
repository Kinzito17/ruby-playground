class User < ApplicationRecord

    validates :username, presence: true, length: {minimum: 2}
    validates :email, presence: true, length: {minimum: 8}

end