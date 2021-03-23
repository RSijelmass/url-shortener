require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        username: "Username",
        password: "somepassword"
      ),
      User.create!(
        username: "Username_2",
        password: "somepassword2"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", text: "Username".to_s, count: 2
  end
end
