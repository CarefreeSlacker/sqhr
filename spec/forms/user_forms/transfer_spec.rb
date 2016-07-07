require 'rails_helper'

describe UserForms::Transfer do
  let(:user){ create(:user) }
  subject{ described_class.new(user) }
  let!(:department){ create(:department) }

  describe 'validations' do
    it 'should not be valid if attributes absent' do
      expect(subject.submit(department_id: nil)).to eq(false)
    end

    it 'valid if attributes present' do
      expect(subject.submit(department_id: department.id)).to eq(true)
    end

    it 'changes attribute_name' do
      new_value = department.id
      subject.submit(department_id: new_value)
      expect(user.reload.department_id).to eq(new_value)
    end

    it 'does not fails if wrong parameter given' do
      expect{subject.submit(unexisting_prameter: 'Fight rebel and riot')}.not_to raise_error
    end

    xcontext 'specific validations' do
      context 'position and department validations' do
        let(:position1){ create(:position, department: department) }
        let(:new_department){ create(:department) }
        let(:position2){ create(:position, department: new_department) }

        it 'should not be valid if position does not belongs to department' do
          expect(subject.submit(department_id: department, position_id: position2)).to eq(false)
        end

        it 'should be valid if position belongs to department' do
          expect(subject.submit(department_id: department, position_id: position1)).to eq(true)
        end
      end

      context 'salary validation' do
        it 'must not allow salary to be less than zero' do
          expect(subject.submit(salary: -123123.12)).to eq(false)
        end
      end
    end
  end

  describe 'history creation' do
    it 'creates history' do
      expect{subject.submit(department_id: department.id)}.to change(subject.history_class, :count).by(1)
    end

    it 'creates history for each attribute' do
      expect{subject.submit(department_id: department.id, salary: 20000.5)}.to change(subject.history_class, :count).by(2)
    end

    it 'does not create history if object invalid' do
      expect{subject.submit(department_id: nil)}.not_to change(subject.history_class, :count)
    end
  end
end