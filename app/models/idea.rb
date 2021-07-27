class Idea < ApplicationRecord
      before_save :capitalize_title
      has_many :reviews, dependent: :destroy
      belongs_to :user, optional: true
      has_many :likes, dependent: :destroy
      has_many :likers, through: :likes, source: :user

      validates :title, presence: {message: "title must be provided"}
      
      validates :title, uniqueness: {scope: :description}
  
      validates :description, length: {minimum: 10, maximum: 500}


      private

      def capitalize_title
            self.title.capitalize!
      end


end
