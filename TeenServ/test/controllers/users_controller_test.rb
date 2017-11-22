# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  email                        :string           default(""), not null
#  encrypted_password           :string           default(""), not null
#  reset_password_token         :string
#  reset_password_sent_at       :datetime
#  remember_created_at          :datetime
#  sign_in_count                :integer          default(0), not null
#  current_sign_in_at           :datetime
#  last_sign_in_at              :datetime
#  current_sign_in_ip           :inet
#  last_sign_in_ip              :inet
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  address_1                    :string
#  address_2                    :string
#  city                         :string
#  province                     :string
#  postal_code                  :string
#  country                      :string
#  home_number                  :string
#  mobile_number                :string
#  age                          :integer
#  image_file_name              :string
#  image_content_type           :string
#  image_file_size              :integer
#  image_updated_at             :datetime
#  profile_picture_file_name    :string
#  profile_picture_content_type :string
#  profile_picture_file_size    :integer
#  profile_picture_updated_at   :datetime
#  group                        :integer
#  first_name                   :string
#  last_name                    :string
#  average_rating               :float
#  latitude                     :float
#  longitude                    :float
#  profile_pic_file_name        :string
#  profile_pic_content_type     :string
#  profile_pic_file_size        :integer
#  profile_pic_updated_at       :datetime
#  stripe_id                    :string
#  balance                      :float            default(0.0)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
