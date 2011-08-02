# Load the rails application
require File.expand_path('../application', __FILE__)

LANGUAGES = {"en" => "English", "vi" => "Vietnamese"}

#APP_CONFIG = YAML::load(File.open("#{::Rails.root.to_s}/config/appconfig.yml"))
APP_CONFIG = {}
APP_CONFIG[:english_website_url] = "0.0.0.0:3000/en/"

# Initialize the rails application
Salonpals::Application.initialize!
