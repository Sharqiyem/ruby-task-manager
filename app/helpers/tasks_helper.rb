module TasksHelper

  def status_badge_class(status)
    case status
    when 'todo'
      'bg-secondary'
    when 'in_progress'
      'bg-primary'
    when 'done'
      'bg-success'
    else
      'bg-light'
    end
  end

  def priority_badge_class(priority)
    case priority
    when 'low'
      'bg-info'
    when 'medium'
      'bg-warning'
    when 'high'
      'bg-danger'
    else
      'bg-light'
    end
  end


  def task_status_badge(status)
    case status
    when 'done' then 'success'
    when 'in_progress' then 'warning'
    else 'secondary'
    end
  end
  
  def task_priority_badge(priority)
    case priority
    when 'high' then 'danger'
    when 'medium' then 'warning'
    else 'info'
    end
  end
end