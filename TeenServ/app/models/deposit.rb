class Deposit < ApplicationRecord
  belongs_to :user

  def has_paypal?
    if self.paypal
      1
    else
      0
    end
  end

end

# == Schema Information
#
# Table name: deposits
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
#
# Indexes
#
#  index_deposits_on_user_id  (user_id)
#
