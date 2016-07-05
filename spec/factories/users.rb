FactoryGirl.define do
  factory :user do
    first_name "MyString"
    last_name "MyString"
    association :department, factory: :department
    association :position, factory: :position
    fired false
    hr_manager false
    salary 1.5
  end
end
