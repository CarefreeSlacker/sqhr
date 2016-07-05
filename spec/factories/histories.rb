FactoryGirl.define do
  factory :history do
    type ""
    association :user, factory: :user
    old_value "MyString"
    new_value "MyString"
    attribute "MyString"
    date "2016-07-05"
  end
end
