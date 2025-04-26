class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.admin?
      can :manage, :all
    else
      # Regular user permissions
      can :manage, Task, user_id: user.id
      can :read, Task, assignee_id: user.id
      can :create, Task
      can :read, Task do |task|
        task.user_id == user.id || task.assignee_id == user.id
      end
    end
  end
end