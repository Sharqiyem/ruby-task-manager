module ApplicationHelper
  def bootstrap_alert_class(flash_type)
    case flash_type.to_sym
    when :notice then "success"
    when :alert  then "danger"
    else "info"
    end
  end
end