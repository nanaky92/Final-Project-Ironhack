module ApplicationHelper
  def isUserAdmin?(group_id)
    current_user == Group.find(group_id).admin
  end
end
