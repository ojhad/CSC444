class Person < ApplicationRecord
  has_many :reviews
end

# == Schema Information
#
# Table name: people
#
#  id            :integer          not null, primary key
#  name          :string
#  email         :string
#  address_1     :string
#  address_2     :string
#  city          :string
#  province      :string
#  postal_code   :string
#  country       :string
#  home_number   :integer
#  mobile_number :integer
#  age           :integer
#  profile_pic   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  type          :string
#