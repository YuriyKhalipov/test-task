class Order < ApplicationRecord
  include AASM

  aasm do
    state :registered, initial: true
    state :сargo_received_from_the_sender, :cargo_has_been_sent, :delivered

    event :change_status do
      before do
        puts "CURRENT STATE: #{aasm.current_state}"
      end

      after do
        puts "NEW STATE: #{aasm.current_state}"
      end

      transitions from: :registered, to: :сargo_received_from_the_sender, if: :registered?
      transitions from: :сargo_received_from_the_sender, to: :cargo_has_been_sent, if: :сargo_received_from_the_sender?
      transitions from: :cargo_has_been_sent, to: :delivered, if: :cargo_has_been_sent?
    end
  end

  belongs_to :user

  validates :weight, presence:true, numericality: {greater_than: 0 }
  validates :length, presence:true, numericality: { only_integer: true, greater_than: 0 }
  validates :width, presence:true, numericality: { only_integer: true, greater_than: 0 }
  validates :height, presence:true, numericality: { only_integer: true, greater_than: 0 }
  validates :distance, presence:true, numericality: {greater_than: 0 }
  validates :origin_location, presence:true
  validates :destination_location, presence:true
  validates :price, presence:true, numericality: {greater_than: 0 }

  paginates_per 5
end
