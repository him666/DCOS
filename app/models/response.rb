class Response < ApplicationRecord
  belongs_to :interaction

  validates :msg, :author, presence: true
end
