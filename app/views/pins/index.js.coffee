
$ ->
	$(".product-index").html("<%= escape_javascript(render 'index') %>")
	$("#product-modal").modal("hide")



$ ->
  $flexcontainer = $("#flexcontainer")
  $flexcontainer.imagesLoaded ->
    $flexcontainer.masonry
      itemSelector: ".itemx"
      columnWidth: ".grid-sizerx"




$ ->
  if $('#infinite-scrolling').size() > 0
    $(window).on 'scroll', ->
      more_pins_url = $('.pagination a[rel=next]').attr('href')
      if more_pins_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
          $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." /><p>Loading</p>')
          $.getScript more_pins_url
          $.ajax
            url: more_pins_url
            success: (data) ->
              $("#flexcontainer").append(data)
      if !more_pins_url
        $('.pagination').html("")
      return
    return
$ ->
  $('.tn img').on 'click'
  $('#mainpic#frame-flipper img').attr 'src', $(this).attr('src')





