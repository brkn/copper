

class Book < ApplicationRecord

  belongs_to :author

  validates :title, presence: true
  validates :genre, presence: true
  validates :published_date, presence: true

  end
