class Payout < ApplicationRecord

  belongs_to :user
end

# == Schema Information
#
# Table name: payouts
#
#  id         :integer          not null, primary key
#  amount     :float
#  batch_id   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#