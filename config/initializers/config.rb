raise "No config file found" unless File.exist?("#{Rails.root}/config/config.yml")
FLAK = YAML.load_file("#{Rails.root}/config/config.yml").with_indifferent_access
