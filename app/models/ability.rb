class Ability
  include CanCan::Ability

  def initialize user, namespace
    user ||= User.new
    if namespace == "admin"
      if user.is_admin?
        can :read, :all
      else
        cannot :manage, :all
      end
    else
      if user.is_admin?
        cannot :manage, :all
      else
        can :manage, Review, user_id: user.id
      end
    end
  end
end
