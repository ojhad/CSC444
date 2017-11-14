# == Schema Information
#
# Table name: finances
#
#  id         :integer          not null, primary key
#  year       :string
#  month      :string
#  amount     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class FinanceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
