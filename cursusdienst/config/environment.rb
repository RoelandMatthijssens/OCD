# Load the rails application
require 'pathname'
require File.expand_path('../application', __FILE__)
RailsRoot = Pathname.new(Rails.root).expand_path
# Initialize the rails application
Cursusdienst::Application.initialize!
