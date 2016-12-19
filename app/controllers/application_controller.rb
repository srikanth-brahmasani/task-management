class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'user_utils'
  include UserUtils
end
