class Suggest < ApplicationRecord
  belongs_to :user
  enum status: {incoming: 0, done: 1}
  scope :newest, ->{order created_at: :desc}
end
