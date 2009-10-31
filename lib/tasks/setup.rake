namespace :flak do
  desc "Set up Flak's config file (includes generating random session secret and site key)"
  task :setup do
    `cp #{Rails.root}/config/config.yml.example #{Rails.root}/config/config.yml`
    `ruby -pi -e 'gsub(/\\{\\{session_secret\\}\\}/, "#{ActiveSupport::SecureRandom.base64(64)}")' -e 'gsub(/\\{\\{site_key\\}\\}/, "#{ActiveSupport::SecureRandom.hex(24)}")' #{Rails.root}/config/config.yml`
  end
end
