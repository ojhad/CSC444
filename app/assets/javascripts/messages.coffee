# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  class Messages
    constructor: ->
      @iter_counter = 0
      @prev_count = 0
      @count_checked = 0
      @currentdate = $.now()
      @currUser = $("[data-behavior='messages-user']").attr("id")
      @convoNum = $("[data-behavior='messages']").attr("id")
      @url_ = 0
      @count_checked = 0
      @num_items = 0
      if @convoNum > 0
        setInterval (=>
          @getNewMessages()
        ), 6000  #edit this interval if want quicker msg appear time

    getNewMessages: ->
      @convoNum = $("[data-behavior='messages']").attr("id")
      @url_ = "/conversations/" + @convoNum + "/messages.json"
      $.ajax(
        url: @url_
        dataType: "JSON"
        method: "GET"
        success: @handleSuccess
      )

    handleSuccess: (data) =>
      @iter_counter = @iter_counter + 1
      count = 0
      currUserID = @currUser
      currUserID = $.trim(currUserID)
      items = $.map data, (message) ->
        message.user_id = $.trim(message.user_id)
        #console.log "there is items!" + count + " message is read is: " + message.read
        if  (message.user_id != currUserID && !message.read)
          #console.log "went inside if"
          count = count + 1
          "<li class =\"left clearfix\">" +
          "<span class=\"chat-img pull-left\">" +
          "<img src=\"#{message.profile_pic}\" alt=\"User Avatar\" class=\"img-circle\" style=\"max-height: 50px; max-width: 50px\" />" +
          "</span>" +
          "<div class=\"chat-body clearfix\">" +
          "<div class=\"header\">" +
          "<strong class=\"primary-font\">" +
          "#{message.first_name} #{message.last_name}" +
          "</strong><small class=\"pull-right text-muted\">" +
          "<span class=\"glyphicon glyphicon-time\"></span>#{message.updated_at}</small>" +
          "</div>" +
          "<p class=\"break-long-words\">#{message.body}</p>" +
          "</div>" +
          "</li>"
      #console.log "count value: " + count
      $("[data-behavior='messages-user']").append(items)
      if (count > 0)
        @postRequest()

    postRequest: ->
      $.ajax(
        url: "/conversations/" + @convoNum + "/messages/mark_as_read"
        dataType: "JSON"
        method: "POST"
        success: ->
          #$('head').append('<style>.conversations-icon:after {background: none;}</style>');
      )
  jQuery ->
    new Messages
$(document).ready(ready)
#$(document).on('turbolinks:load', ready)