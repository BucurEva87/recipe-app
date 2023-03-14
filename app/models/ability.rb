class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, Food, author_id: user.id
  end
end
