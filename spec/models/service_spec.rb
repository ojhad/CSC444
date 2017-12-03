require 'rails_helper'

RSpec.describe Service, type: :model do
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:charge_per_hour) }
  it { should validate_numericality_of(:charge_per_hour) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:min_age) }
  it { should validate_numericality_of(:min_age) }
  it { should validate_presence_of(:max_age) }
  it { should validate_numericality_of(:max_age) }
end