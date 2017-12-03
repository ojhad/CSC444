require 'rails_helper'

RSpec.describe Service, type: :model do
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:charge_per_hour) }
end