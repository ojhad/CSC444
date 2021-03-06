class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :services, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_many :endorsements, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  has_many :service_users, :dependent => :destroy
  has_many :payouts
  has_one :payout_information, :dependent => :destroy
  has_many :client_transactions, :class_name => 'Transaction', :foreign_key => 'client_id', :dependent => :destroy
  has_many :teen_transactions, :class_name => 'Transaction', :foreign_key => 'teen_id', :dependent => :destroy
  has_many :charges, :dependent => :destroy
  has_many :teen_times, :dependent => :destroy
  has_many :service_jobs, through: :service_users, source: :service, :dependent => :destroy
  has_many :endorsement_requests, :class_name => 'EndorsementRequest', :foreign_key => 'user_id', :dependent => :destroy
  has_many :endorsement_invites, :class_name => 'EndorsementRequest', :foreign_key => 'invitee_id', :dependent => :destroy
  has_many :conversations, :foreign_key => :sender_id, :dependent => :destroy

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def is_teen?
     self.group == 0
  end

  def is_client?
    self.group == 1
  end

  def is_sadmin?
    self.group == 2
  end

  def is_admin?
    self.group == 2 || self.group == 3
  end

  def is_CSR?
    self.group == 2 || self.group == 3 || self.group == 4
  end

  def get_address
    self.postal_code
  end

  def type_of_services_to_view
    self.is_teen? ? 1 : 0
  end

  def show_rating?
    self.reviews.count > 5
  end

  def create_payout_information
    @payout_entry = PayoutInformation.new(:user_id=>self.id)
    @payout_entry.save!
  end

  #gets lat & long for user
  geocoded_by :get_address

  after_validation :geocode

  has_attached_file :profile_pic
  validates_attachment_content_type :profile_pic, content_type: /\Aimage\/.*\z/

  after_create :create_payout_information

  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude


end

# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  reset_password_token     :string
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0), not null
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :inet
#  last_sign_in_ip          :inet
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  address_1                :string
#  address_2                :string
#  city                     :string
#  province                 :string
#  postal_code              :string
#  country                  :string
#  home_number              :string
#  mobile_number            :string
#  age                      :integer
#  group                    :integer
#  first_name               :string
#  last_name                :string
#  average_rating           :float
#  latitude                 :float
#  longitude                :float
#  profile_pic_file_name    :string
#  profile_pic_content_type :string
#  profile_pic_file_size    :integer
#  profile_pic_updated_at   :datetime
#  stripe_id                :string
#  balance                  :float            default(0.0)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
