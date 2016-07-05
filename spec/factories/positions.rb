FactoryGirl.define do
  factory :position do
    name "MyString"
    association :department, factory: :department
  end
end
