class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(method,word)
    if method == "forward_match"
       @books = Book.where("text LIKE?","#{word}%")
    elsif method == "backward_match"
       @books = Book.where("text LIKE?","%#{word}")
    elsif method == "perfect_match"
       @books = Book.where("#{word}")
    elsif method == "partial_match"
       @books = Book.where("text LIKE?","%#{word}%")
    else
       @books = Book.all
    end
  end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
