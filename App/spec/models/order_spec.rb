require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:weight) }
  it { is_expected.to validate_numericality_of(:weight) }

  it { is_expected.to validate_presence_of(:length) }
  it { is_expected.to validate_numericality_of(:length) }

  it { is_expected.to validate_presence_of(:width) }
  it { is_expected.to validate_numericality_of(:width) }

  it { is_expected.to validate_presence_of(:height) }
  it { is_expected.to validate_numericality_of(:height) }

  it { is_expected.to validate_presence_of(:distance) }
  it { is_expected.to validate_numericality_of(:distance) }

  it { is_expected.to validate_presence_of(:origin_location) }
  it { is_expected.to validate_presence_of(:destination_location) }

  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_numericality_of(:price) }

  it { is_expected.to transition_from(:registered).to(:сargo_received_from_the_sender).on_event(:change_status) }
  it { is_expected.to transition_from(:сargo_received_from_the_sender).to(:cargo_has_been_sent).on_event(:change_status) }
  it { is_expected.to transition_from(:cargo_has_been_sent).to(:delivered).on_event(:change_status) }

  it { is_expected.not_to transition_from(:delivered).to(:registered).on_event(:change_status) }
  it { is_expected.not_to transition_from(:registered).to(:cargo_has_been_sent).on_event(:change_status) }
  it { is_expected.not_to transition_from(:cargo_has_been_sent).to(:сargo_received_from_the_sender).on_event(:change_status) }
end
