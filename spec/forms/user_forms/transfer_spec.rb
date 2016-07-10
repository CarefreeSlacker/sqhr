require 'rails_helper'

describe UserForms::Transfer do
  let(:user){ create(:user) }
  subject{ described_class.new(user) }
  let!(:department){ create(:department) }
  let!(:position){ create(:position, department: department) }

  describe 'validations' do
    it 'should not be valid if attributes absent' do
      expect(subject.submit(department_id: nil, position_id: position.id)).to eq(false)
    end

    it 'valid if attributes present' do
      expect(subject.submit(department_id: department.id, position_id: position.id)).to eq(true)
    end

    it 'changes attribute_name' do
      new_value = department.id
      subject.submit(department_id: new_value, position_id: position.id)
      expect(user.reload.department_id).to eq(new_value)
    end

    it 'does not fails if wrong parameter given' do
      expect{subject.submit(unexisting_prameter: 'Fight rebel and riot')}.not_to raise_error
    end

    context 'specific validations' do
      context 'position and department validations' do
        let!(:new_department){ create(:department) }
        let!(:position2){ create(:position, department: new_department) }

        it 'should not be valid if position does not belongs to department' do
          expect(subject.submit(department_id: department.id, position_id: position2.id)).to eq(false)
        end

        it 'should be valid if position belongs to department' do
          expect(subject.submit(department_id: department.id, position_id: position.id)).to eq(true)
        end
      end

      context 'salary validation' do
        it 'must not allow salary to be less than zero' do
          expect(subject.submit(salary: -123123.12)).to eq(false)
        end
      end

      it 'invalid if user fired' do
        user.update_attribute 'fired', true
        expect(subject.submit(first_name: 'NewValue')).to eq(false)
      end
    end
  end

  describe 'history creation' do
    let!(:new_department){ create(:department) }
    let!(:position2){ create(:position, department: new_department) }
    let!(:other_position){ create(:position, department: department) }

    it 'creates history' do
      expect{subject.submit(department_id: new_department.id, position_id: position2.id)}.to change(subject.history_class, :count).by(2)
    end

    it 'creates history only for changed ' do
      user.update_attribute 'department_id', department.id
      expect{subject.submit(department_id: department.id, position_id: other_position.id)}.to change(subject.history_class, :count).by(1)
    end

    it 'creates history for each attribute' do
      expect{subject.submit(department_id: department.id, position_id: position.id, salary: 20000.5)}.to change(subject.history_class, :count).by(3)
    end

    it 'does not create history if object invalid' do
      expect{subject.submit(department_id: nil, position_id: position.id)}.not_to change(subject.history_class, :count)
    end
  end
end