class UserForms::Fire < UserForms::Base
  model_attributes :fired

  attr_accessor :reason

  def submit(params)
    create_reason_history(params)
    super(params)
  end

  private

  def create_reason_history(params)
    reason = params.delete(:reason)
    @histories << new_history('reason', '', reason)
  end

  def user_can_not_be_fired
    true
  end
end