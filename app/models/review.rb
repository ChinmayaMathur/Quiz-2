class Review < ApplicationRecord
      belongs_to :user, optional: true
      belongs_to :idea

      validates :body, length: { minimum: 5, maximum: 500}
end
