class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include FiltersHelper
  include ActionLogsHelper

end
