class Service < ApplicationRecord

	#Scopes
	scope :status, ->(status) { where('services.status = ?', status) }
	scope :viewable_services, ->(user) {
		joins(:user).where('users.group' => user.type_of_services_to_view)
	}

	# Status Options Constants Start
	UNLISTED = 0 # service not yet publicly visible
	LISTED = 1 # service posted, publicly visible, and accepting user requests
	ACCEPTED = 2 # service accepted by both users and no longer visible to the public
	COMPLETED = 3 # service has been completed and money has exchanged hands
	# Status Options Constants End

	SERVICE_TYPES = ["Babysitting", "Yard work", "Snow shoveling", "Furniture moving",
					"Simple cleaning tasks", "Vacation services", "Dog walking", "Computer help",
					"Tutoring", "Reading", "Other"]

	belongs_to :user
	has_many :service_users, :dependent => :destroy
  has_many :transactions, :dependent => :destroy

	validates :user_id, presence: true
	validates :title, presence: true
	validates :charge_per_hour, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :min_age, presence: true, numericality: { greater_than_or_equal_to: 13 }
	validates :min_age, presence: true, :numericality => {less_than_or_equal_to: :max_age, :message => "can't be greater than Max Age"}
	validates :max_age, presence: true, numericality: { greater_than_or_equal_to: 13, less_than_or_equal_to: 19 }
	validates :status, presence: true, inclusion: { in: [UNLISTED, LISTED, ACCEPTED, COMPLETED], 
													message: "-- Oops something went wrong! Please try again or contact customer support." }

	def self.search(search_term)
		if search_term
			where("title ILIKE ?", "%#{search_term}%").order("created_at DESC")
		else
			order("created_at DESC")
		end
	end

end

# == Schema Information
#
# Table name: services
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  title           :string
#  charge_per_hour :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  status          :integer
#  frequency       :integer
#  min_age         :integer
#  max_age         :integer
#  other_title     :string
#  description     :string
#  skill           :integer
#  duration        :decimal(, )
#  date            :time
#  start_time      :time
#  end_time        :time
#  day             :string
#
# Indexes
#
#  index_services_on_user_id  (user_id)
#