class PayoutInformation < ApplicationRecord
  belongs_to :user

  def has_paypal?
    self.paypal.blank?

  end

  def no_address?
    self.address_1.blank?
  end
end

# == Schema Information
#
# Table name: payout_informations
#
#  id          :integer          not null, primary key
#  paypal      :string
#  address_1   :string
#  address_2   :string
#  city        :string
#  province    :string
#  postal_code :string
#  country     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  method      :string           default("check")
#
# Indexes
#
#  index_deposit_information_on_user_id  (user_id)
#
