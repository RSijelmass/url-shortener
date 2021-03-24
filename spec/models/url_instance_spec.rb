require 'rails_helper'

RSpec.describe UrlInstance, type: :model do
  let(:user) { User.create(id: 1234, username: "someUser") }
  let(:valid_parameters) { { longhand: "somelonghand", shorthand: "someshorthand", user_id: user.id } }
  let(:parameters_missing_longhand) { { shorthand: "someshorthand", user_id: user.id } }
  let(:parameters_missing_user) { { longhand: "somelonghand", shorthand: "someshorthand" } }

  context "with valid parameters" do
    it 'stores a UrlInstance when all valid parameters are given' do
      expect { UrlInstance.create(valid_parameters) }.to change { UrlInstance.count }.by(1)
    end
  end

  context "with invalid parameters" do
    it 'does not store a UrlInstance when we are missing a longhand' do
      expect { UrlInstance.create(parameters_missing_longhand) }.to_not change { UrlInstance.count }
    end
    it 'does not store a UrlInstance when we are missing a user ID' do
      expect { UrlInstance.create(parameters_missing_user) }.to_not change { UrlInstance.count }
    end
  end
end
