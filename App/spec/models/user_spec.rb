require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { is_expected.to have_many(:orders) }

  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:patronymic) }
  it { is_expected.to validate_presence_of(:phone) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  

  it { is_expected.to validate_length_of(:last_name).is_at_most(50) }
  it { is_expected.to validate_length_of(:first_name).is_at_most(50) }
  it { is_expected.to validate_length_of(:patronymic).is_at_most(50) }
  it { is_expected.to validate_length_of(:phone).is_at_most(15) }
end