class UserForms::Base
  include ActiveModel::Validations
  include ActiveModel::Callbacks

  attr_reader :user, :histories, :today

  validate :user_can_not_be_fired

  def self.model_attributes(*attributes_list)
    @@attributes_list = attributes_list
    attributes_list.map!{|attribute| [attribute, "#{attribute}=".to_sym] }.flatten!
    delegate *attributes_list, to: :user
  end

  validate :validate_model

  def initialize(user)
    @user = user
    @today = Date.today
  end

  def submit(params)
    initialize_histories(params.slice(*permitted_attributes))
    if valid?
      user.save
      create_histories
      true
    else
      false
    end
  end

  def to_model
    user
  end

  def history_class
    "Histories::#{self.class.name.demodulize}".constantize
  end

  private

  def permitted_attributes
    @@attributes_list
  end

  def create_histories
    @histories.map do |history|
      history.save!
    end
  end

  def initialize_histories(params)
    @histories = []
    params.each do |attribute, new_value|
      old_value = user.send(attribute)

      next if new_value == old_value
      @histories << history_class.new(user_id: user.id,
                                      old_value: old_value,
                                      new_value: new_value,
                                      attribute_name: attribute,
                                      date: today)
      send "#{attribute}=", new_value
    end
  end

  def validate_model
    unless user.valid?
      user.errors.each do |attribute, message|
        self.errors.add(attribute, message)
      end
    end
  end

  def user_can_not_be_fired
    if user.fired?
      self.errors.add(:base, 'Нельзя производить действия на дуволенными сотрудниками')
    end
  end
end