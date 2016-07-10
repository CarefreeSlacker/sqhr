require 'rails_helper'

describe UserForms::EditName do
  let(:user){ create(:user) }
  subject{ described_class.new(user) }

  describe 'validations' do
    it 'should not be valid if attributes absent' do
      expect(subject.submit(first_name: nil)).to eq(false)
    end

    it 'valid if attributes present' do
      expect(subject.submit(first_name: 'NewValue')).to eq(true)
    end

    it 'changes attribute_name' do
      new_value = 'NewValue'
      subject.submit(first_name: 'NewValue')
      expect(user.reload.first_name).to eq(new_value)
    end

    it 'does not fails if wrong parameter given' do
      expect{subject.submit(unexisting_prameter: 'Fight rebel and riot')}.not_to raise_error
    end

    it 'invalid if user fired' do
      user.update_attribute 'fired', true
      expect(subject.submit(first_name: 'NewValue')).to eq(false)
    end
  end

  describe 'history creation' do
    it 'creates history' do
      expect{subject.submit(first_name: 'NewValue')}.to change(subject.history_class, :count).by(1)
    end

    it 'creates history for each attribute' do
      expect{subject.submit(first_name: 'NewValue', last_name: 'NewValue')}.to change(subject.history_class, :count).by(2)
    end

    it 'does not create history if object invalid' do
      expect{subject.submit(first_name: nil)}.not_to change(subject.history_class, :count)
    end
  end
end