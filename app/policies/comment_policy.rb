class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user
  end

  def show?
    index?
  end

  def update?
    record.user == user
  end
end
