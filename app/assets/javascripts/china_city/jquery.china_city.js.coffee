(($) ->
  $.fn.china_city = () ->
    @each ->
      selects = $(@).find('.city-select')
      zipcode_input = $(@).find('.zipcode')
      selects.change ->
        $this = $(@)
        next_selects = selects.slice(selects.index(@) + 1) # empty all children city
        $("option:gt(0)", next_selects).remove()
        if selects.index(@) == 2
          selected_data = $this.data('china_city').filter(
            (item) ->
              return item[1] == $this.val()
          )[0]
          zipcode = selected_data[2] if selected_data?
          zipcode_input.val(zipcode)
        if next_selects.first()[0] and $this.val() # init next child
          $.get "/china_city/#{$(@).val()}", (data) ->
            data = data.data if data.data?
            next_selects.first()[0].options.add(new Option(option[0], option[1])) for option in data
            next_selects.first().data('china_city', data)
            # init value after data completed.
            next_selects.trigger('china_city:load_data_completed')

  $(document).on 'ready page:load', ->
    $('.city-group').china_city()
)(jQuery)
