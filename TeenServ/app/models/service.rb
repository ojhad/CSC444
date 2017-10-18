class Service < ApplicationRecord

	SERVICE_TYPES = ["Baby sitting", "Yard work", "Snow shoveling", "Furniture moving",
					"Simple cleaning tasks", "Vacation services", "Dog walking", "Computer help",
					"Tutoring", "Reading", "Other"]

	belongs_to :user

	validates :user_id, presence: true
	validates :service_title, presence: true
	validates :charge_per_hour, presence: true
end
