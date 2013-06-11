# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

trelloAuthorization = ()->
  Trello.authorize
    name: "Github-Trello"
    persist: false
    scope:
      account: true
      read: true
      write: true
    expiration: "never"
    success: ()->
      token = Trello.token()
      $("#user_auth_token").val(token)
      Trello.get "tokens/#{token}/member/email",
      (result)->
        email = result._value
        $("#user_email").val(email)
        $("#create_user_btn").click()

trelloAuthorization()