class Article < ActiveRecord::Base
  validates :content, presence: true
  validates :title, presence: true

  has_many :comments, inverse_of: :article, dependent: :destroy
end
