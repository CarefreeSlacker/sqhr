require 'rails_helper'

RSpec.xdescribe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :first_name => "MyString",
      :last_name => "MyString",
      :department => nil,
      :position => nil,
      :salary => 1.5,
      :fired => false,
      :hr_manager => false
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input#user_first_name[name=?]", "user[first_name]"

      assert_select "input#user_last_name[name=?]", "user[last_name]"

      assert_select "input#user_department_id[name=?]", "user[department_id]"

      assert_select "input#user_position_id[name=?]", "user[position_id]"

      assert_select "input#user_salary[name=?]", "user[salary]"

      assert_select "input#user_fired[name=?]", "user[fired]"

      assert_select "input#user_hr_manager[name=?]", "user[hr_manager]"
    end
  end
end
