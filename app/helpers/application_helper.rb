module ApplicationHelper
  require 'user_utils'
  include UserUtils
  PriorityValues = [1,2,3,4,5,6]

  def user_emails
    get_user_emails
  end
end
