require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_parameters) { { username: "someusername", password: "somepassword" } }
  let(:parameters_missing_username) { { password: "somepassword" } }
  let(:parameters_missing_password) { { username: "someusername" } }

  it 'allows me to create a user with all valid parameters given' do
    expect { User.create(valid_parameters) }.to change { User.count }.by(1)
  end
  it 'does not allow me to create two users with the same username' do
    expect { 2.times { User.create(valid_parameters) } }.to change { User.count }.by(1)
  end
  it 'does not allow me to create a user with a missing username' do
    expect { User.create(parameters_missing_username) }.to_not change { User.count }
  end
  it 'does not allow me to create a user with a missing username' do
    expect { User.create(parameters_missing_password) }.to_not change { User.count }
  end
end
