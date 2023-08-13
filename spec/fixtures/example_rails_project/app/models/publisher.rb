
class Publisher<ApplicationRecord

  validates :name,presence: true
  validates_presence :address
  has_many :books,dependent: :destroy

  end
