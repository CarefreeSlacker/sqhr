require 'rails_helper'

xdescribe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :department => nil,
        :position => nil,
        :salary => 2.5,
        :fired => false,
        :hr_manager => false
      ),
      User.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :department => nil,
        :position => nil,
        :salary => 2.5,
        :fired => false,
        :hr_manager => false
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
