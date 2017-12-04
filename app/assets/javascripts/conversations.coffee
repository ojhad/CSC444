# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  class Conversations
    constructor: ->
      @currUser = $("[data-behavior='conversations']").attr("id")
      @conversations = $("[data-behavior='conversations']")
      @count_checked = 0
      @num_items = 0
      @audio = new Audio('/assets/button_tiny.mp3')
      @setup()
      setInterval (=>
        @getNewConversations()
      ), 5000

    getNewConversations: ->
      $.ajax(
        url: "/conversations"
        dataType: "JSON"
        method: "GET"
        success: @handleSuccess
      )

    handleClick: (e) =>
      $.ajax(
        url: "/conversations/mark_as_read"
        dataType: "JSON"
        method: "POST"
        success: ->
          $('head').append('<style>.notification-icon:after {background: none;}</style>');
          $("[data-behavior='unread-count']").attr("data-count","")
      )
    handleSuccess: (data) =>
      count = 0
      console.log @count_checked
      @count_checked = @count_checked + 1
      currUserID = @currUser
      currUserID = $.trim(currUserID)
      items = $.map data, (notification) ->
        notification.user_id = $.trim(notification.user_id)
        if  (notification.user_id == currUserID )
          if (!notification.read)
            count = count + 1
          "<div class=\"notification new\" ng-repeat=\"notification in newConversations.slice().reverse() track by notification.timestamp\">" +
            "<div class=\"notification-text\">\n" +
            "<span class=\"highlight\">#{notification.title}</span>" +
            "</div>" +
            "</div>"
      $("[data-behavior='conversation-items']").html(items)
      if (items.length != 0 && count >0)
        $("[data-behavior='unread-count']").attr("data-count",count)
        $('head').append('<style>.notification-icon:after {background: gold;}</style>');
        if (@count_checked > 2 && @num_items != items.length)
          @audio.play()
        #console.log @count_checked
        if (@count_checked == 0)
          console.log "hello"
        @num_items = items.length
#@count_checked = @count_checked + 1
      else
        $("[data-behavior='unread-count']").attr("data-count","")
        $('head').append('<style>.notification-icon:after {background: none;}</style>');
  jQuery ->
    new Conversations
$(document).ready(ready)
#$(document).on('turbolinks:load', ready)