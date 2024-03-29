# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_VDMS-Code_session',
  :secret      => '8bf1f1621c7063f5438405fdb866a5c59aeb3ccb7ade03faf6a683a5cf98e669b529882799fe4f15d3a2fe60ee8afee90681b2bfa12a0801879f156fb8b1d3b9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
