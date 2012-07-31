# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(window).load( ->
    #$('#event_details_1').scrollToFixed( marginTop:70, left:0, limit: $('.event_count_2').offset().top - $('#event_details_1').height() - 30  )
    

    $('.calendar-grid').live('click', ->
      spinner = new Spinner().spin();
      $('.load').append(spinner.el);
      
      
      $.ajax(
        async:true,
        type:'POST',
        url:'../../date/'+parseInt($(this).html())+'/'+$(this).attr('month')+'/'+$(this).attr('year'),
        success: (msg) ->
          #
          spinner.stop()
        ,
        error: (msg) ->
          #
          spinner.stop()
      )
      
    )
)