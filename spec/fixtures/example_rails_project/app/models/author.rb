class Author< ApplicationRecord

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :books, dependent: :destroy

  end
