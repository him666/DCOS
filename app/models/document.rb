class Document < ApplicationRecord
  belongs_to :organization
  has_many :chapters, dependent: :destroy
  validates :name, presence: true
end
