class Transaction < ApplicationRecord
  belongs_to :teen, :class_name => 'User'
  belongs_to :client, :class_name => 'User'
  belongs_to :service
end

# == Schema Information
#
# Table name: transactions
#
#  id              :integer          not null, primary key
#  total_amount    :float
#  number_of_hours :float
#  charge_per_hour :float
#  service_title   :text
#  teen_id         :integer
#  client_id       :integer
#  service_id      :integer
#
# Indexes
#
#  index_transactions_on_client_id   (client_id)
#  index_transactions_on_service_id  (service_id)
#  index_transactions_on_teen_id     (teen_id)
#
