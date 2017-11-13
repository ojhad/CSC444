class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :services, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_and_belongs_to_many :skills
  has_many :service_users
  has_many :payouts
  has_one :deposit_information
  has_many :client_transactions, :class_name => 'Transaction', :foreign_key => 'client_id'
  has_many :teen_transactions, :class_name => 'Transaction', :foreign_key => 'teen_id'


  def full_name
    self.first_name + ' ' + self.last_name
  end

  def is_teen?
     self.group == 0
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

  def create_deposit
    @deposit_entry = DepositInformation.new(:user_id=>self.id)
    @deposit_entry.save!
  end

  #gets lat & long for user
  geocoded_by :get_address

  after_validation :geocode

  has_attached_file :profile_pic
  validates_attachment_content_type :profile_pic, content_type: /\Aimage\/.*\z/

  after_create :create_deposit


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
