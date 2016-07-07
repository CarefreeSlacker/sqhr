require 'rails_helper'

describe User, type: :model do
  subject{ create(:user) }

  it{ is_expected.to belong_to(:department) }
  it{ is_expected.to belong_to(:position) }
  it{ is_expected.to have_many(:histories) }

  it 'validate presence of first_name' do
    subject.first_name = nil
    expect(subject).not_to be_valid
  end

  it 'validate presence of last_name' do
    subject.last_name = nil
    expect(subject).not_to be_valid
  end

  it 'validate presence of position' do
    subject.position_id = nil
    expect(subject).not_to be_valid
  end

  it 'validate presence of department' do
    subject.department_id = nil
    expect(subject).not_to be_valid
  end

  describe 'callbacks' do
    describe 'after_create' do
      let(:user) { build(:user) }

      it 'should create new Histories::Fire instance' do
        expect{ user.save }.to change(Histories::Hire, :count).by(1)
      end
    end
  end
end
