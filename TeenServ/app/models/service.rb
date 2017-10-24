class Service < ApplicationRecord

	SERVICE_TYPES = ["Baby sitting", "Yard work", "Snow shoveling", "Furniture moving",
					"Simple cleaning tasks", "Vacation services", "Dog walking", "Computer help",
					"Tutoring", "Reading", "Other"]

	belongs_to :user

	validates :user_id, presence: true
	validates :service_title, presence: true
	validates :charge_per_hour, presence: true
end

# == Schema Information
#
# Table name: services
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  service_title   :string
#  charge_per_hour :float
#  user_type       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_services_on_user_id  (user_id)
#
