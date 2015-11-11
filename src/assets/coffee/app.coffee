((window, document, $) ->
    $ document 
        .ready ->
            $ '.sidebar > .nav.nav-menu > li > a'
                .click (event) ->
                    $this = $ this
                    $currentItem = $this.closest 'li'
                    $currentSubmenu = $currentItem.find '.nav.nav-menu'
                    
                    if $currentSubmenu.length > 0
                        event.preventDefault()

                        if $currentItem.hasClass 'opened'
                            $currentItem.removeClass 'opened'
                        else
                            $currentItem.addClass 'opened'

                        $currentItem
                            .siblings 'li'
                            .removeClass 'opened'

)(window, document, jQuery)