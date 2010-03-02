# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_zip_session',
  :secret      => 'c75877dc2b637809b0c7fbb139f4aff6be66bfde29fba671fdb41567d15b4f9eeb3b3824a79ffcec7e067def01f4fbc649abe7d76ed62075297f60c75ac78cba'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
