class User < ActiveRecord::Base
  EDIT_ACTIONS = %w(transfer edit_names fire)

  belongs_to :department
  belongs_to :position
  has_many :histories

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :department, presence: true
  validates :position, presence: true

  after_create :create_fire_history

  private

  def create_fire_history
    Histories::Hire.create(user_id: self.id, date: Date.today)
  end
end
