class UserFormFactoryService
  attr_reader :user, :user_form

  def initialize(user, action_name)
    @user = user
    @user_form = choose_form(action_name)
  end

  private

  def choose_form(action_name)
    return user unless action_name
    "UserForms::#{action_name.camelize}".constantize.new(user)
  end
end