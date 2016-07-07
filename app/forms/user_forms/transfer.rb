class UserForms::Transfer < UserForms::Base
  model_attributes :department_id, :position_id, :salary

  # TODO остановился на создании тестов для этих валидаций
  # validate :position_must_belongs_to_department
  # validate :salary_must_be_more_than_zero
  #
  # private
  #
  # def position_must_belongs_to_department
  #   if position_id.present? && Position.find_by(id: position_id).try(:department_id) != department_id
  #     self.errors.add(:position, 'Position must belongs to department')
  #   end
  # end
  #
  # def salary_must_be_more_than_zero
  #   unless salary > 0
  #     self.errors.add(:salary, 'Can not be less thant zero')
  #   end
  # end
end