require "rails/all"

CONFIG = YAML.load_file("#{Rails.root.to_s}/config/appsettings.yml")[Rails.env]
CONFIG.map do |k,v|
  Rails.configuration.send("#{k}=", v)
end