class Order < ApplicationRecord
  enum status: {incoming: 0, in_progress: 1, finished: 2}
  belongs_to :user
  has_many :order_details, dependent: :destroy
  scope :newest, ->{order created_at: :desc}
end
