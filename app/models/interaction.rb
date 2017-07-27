class Interaction < ApplicationRecord
  belongs_to :content
  has_many :responses, dependent: :destroy
  validates :msg, :by_who, :author, presence: true
end
