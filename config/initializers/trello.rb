#require 'trello'
#
#include Trello
#include Trello::Authorization
#
#Trello.configure do |config|
#  config.consumer_key    = 'f8947184de87275b7d2d7d8a7cad978f'
#  config.consumer_secret = "506c0d9127cf52eaa22f240533c4cc5894a5e227ecd08d888c13cb4a6fb9aad4"
#  config.return_url      = "localhost:3000"
#  config.callback        = lambda { |request_token|
#    debugger
#    #DB.save(request_token.key, request_token.secret)
#  }
#end