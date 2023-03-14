class Ability
  include CanCan::Ability
  def initialize(user)
    can :add_new_food, Recipe do |recipe|
      recipe.user == user
    end
  end
end
