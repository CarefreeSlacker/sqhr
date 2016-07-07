FactoryGirl.define do
  factory :history do
    association :user, factory: :user
    old_value "MyString"
    new_value "MyString"
    attribute_name "MyString"
    date "2016-07-05"

    factory :transfer, class: Histories::Transfer
    factory :fire, class: Histories::Fire
    factory :hire, class: Histories::Hire
    factory :edit_name, class: Histories::EditName
  end
end
