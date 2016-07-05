# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Department.any?
  departments = [
    { id: 1, name: 'Административный' },
    { id: 2, name: 'Финансовый' },
    { id: 3, name: 'Разработки' },
    { id: 4, name: 'Маркетинга' }
  ]

  departments.each do |department_attributes|
    Department.create!(department_attributes)
  end
end

unless Position.any?
  positions = [
      { id: 1, department_id: 1, name: 'Директор' },
      { id: 2, department_id: 2, name: 'Финансовый директор' },
      { id: 3, department_id: 2, name: 'Бухгалтер' },
      { id: 4, department_id: 3, name: 'Тимлид' },
      { id: 5, department_id: 3, name: 'Бэкенд рзаработчик' },
      { id: 6, department_id: 3, name: 'Фронтенд разработчик' },
      { id: 7, department_id: 4, name: 'Директор по маркетингу' },
      { id: 8, department_id: 4, name: 'Специалист по SMM' },
      { id: 9, department_id: 4, name: 'Специалист по SEO' },
      { id: 10, department_id: 4, name: 'Копирайтер' }
  ]

  positions.each do |position_attributes|
    Position.create!(position_attributes)
  end
end