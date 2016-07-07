class UserForms::Base
  include ActiveModel::Validations
  include ActiveModel::Callbacks

  attr_reader :user, :histories, :today

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
      create_histories
      user.save
      true
    else
      false
    end
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
    params.each do |attribute, value|
      @histories << history_class.new(user_id: user.id,
                                      old_value: user.send(attribute),
                                      new_value: value,
                                      attribute_name: attribute,
                                      date: today)
      send "#{attribute}=", value
    end
  end

  def validate_model
    unless user.valid?
      user.errors.each do |attribute, message|
        self.errors.add(attribute, message)
      end
    end
  end
end