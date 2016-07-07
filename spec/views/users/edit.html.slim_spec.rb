require 'rails_helper'

xdescribe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :department => nil,
      :position => nil,
      :salary => 1.5,
      :fired => false,
      :hr_manager => false
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

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
