class Transaction < ApplicationRecord
  belongs_to :teen, :class_name => 'User'
  belongs_to :client, :class_name => 'User'
  belongs_to :service
  before_save :compute_total
  enum status: [ :not_approved, :teen_approved, :client_approved, :completed ]
  scope :completed, -> { where(status: :completed) }
  scope :not_approved, -> { where(status: :not_approved) }
  scope :teen_approved, -> { where(status: :teen_approved) }
  scope :client_approved, -> { where(status: :client_approved) }
  private

  def compute_total
    self.total_amount = self.charge_per_hour * self.number_of_hours
  end
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
#  status          :integer          default("not_approved"), not null
#
# Indexes
#
#  index_transactions_on_client_id   (client_id)
#  index_transactions_on_service_id  (service_id)
#  index_transactions_on_teen_id     (teen_id)
#
