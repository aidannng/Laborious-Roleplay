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

    $('#plates').empty();
    display(false)

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
    }
})