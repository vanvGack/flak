class Flak

  cattr_accessor :settings

  if File.exist?("#{Rails.root}/config/config.yml")
    self.settings = YAML.load_file("#{Rails.root}/config/config.yml").with_indifferent_access
  end

  def self.method_missing(method_name)
    settings[method_name] || ENV["FLAK_"+method_name.to_s.upcase]
  end

end
