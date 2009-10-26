# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_flak_session',
  :secret      => '7df22a0b336b2cd601af49dce382aec00e679c4ad24b64814771b719ec94e7a3e79d64fe4b8ee83a31dff612b3ae550ac75d69e58698531b083879817e0f1429'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
