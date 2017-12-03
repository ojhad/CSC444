FactoryGirl.define do
  factory :service do
    status 0
    charge_per_hour 5
    title "service title"
    user_id 1
    min_age 13
    max_age 16
  end
end