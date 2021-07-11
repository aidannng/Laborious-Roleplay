$(function () {
    $('#getvehicles').click(function(){
        $.post('http://customs-nui/event', JSON.stringify({}));
        return
    });


    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    $("#buyScrap").click(function () {
        var part = 'scrapmetal';
        var price = 5;
        var amount = $('#scrapCount').val();
        $.post('http://customs-nui/buymaterial', JSON.stringify({
            part:part,
            price:price,
            amount:amount,
        }));
        
        var amount = $('#scrapCount').val('');
    });

    $("#buyAluminum").click(function () {
        var part = 'aluminum';
        var price = 10;
        var amount = $('#aluminumCount').val();
        $.post('http://customs-nui/buymaterial', JSON.stringify({
            part:part,
            price:price,
            amount:amount,
        }));
        var amount = $('#aluminumCount').val('');
    });


    $("#buyRubber").click(function () {
        var part = 'rubber';
        var price = 5;
        var amount = $('#rubberCount').val();
        $.post('http://customs-nui/buymaterial', JSON.stringify({
            part:part,
            price:price,
            amount:amount,
        }));
        var amount = $('#rubberCount').val('');
    });


    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                $('#plates').empty();
                display(true)
            } else {
                display(false)
            }
        }
        
        if(item.plates != null)
        {
            var plates = item.plates.split(',')
            for (i = 0; i < plates.length; ++i) {
                $('#plates').append("<p>" + plates[i] + "</p>");
            }
            
        }
        
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            resetUI()

            $.post('http://Customs-NUI/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        resetUI()

        $.post('http://Customs-NUI/exit', JSON.stringify({}));
        return
    })

    function resetUI()
    {
        $('.accordion-button').each(function(){
            $(this).addClass('collapsed').attr('area-expanded', false)
        });
		
		$('.accordion-collapse').each(function(){
            $(this).addClass('collapse').removeClass('show')
        });

        $('.nav-link').each(function(){
            $(this).removeClass('active').attr('aria-selected', 'false')
        })

        $('.tab-pane').each(function(){
            $(this).removeClass('active').removeClass('show');
        })

        $('#nav-home').addClass('active').addClass('show');

        $('#nav-home-tab').addClass('active').attr('aria-selected', 'true');
    }
})