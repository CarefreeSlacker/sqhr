class History < ActiveRecord::Base
  belongs_to :user

  def type_name
    type_underscore = self.class.name.demodulize.underscore
    text = I18n.t("histories.active_record.type.#{type_underscore}")
    "<span class=\"#{type_underscore}\">#{text}</span>".html_safe
  end
end
