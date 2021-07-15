$(function () {
    display(false)
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }
    

    $('#create-bill').click(function(){
        var luckyNumber = $('#luckyNumber').val();
        var purchasePrice = $('#purchasePrice').val();
        var termLength = $('#termLength').val();
        if(luckyNumber != '' && purchasePrice != '' && termLength != '')
        {
            $('#error').empty();
            $('#bills').empty();

            $('#luckyNumber').val('');
            $('#purchasePrice').val('');
            $('#termLength').val('');
            
            $.post('http://customs-nui/createbill', JSON.stringify({
                luckyNumber:luckyNumber,
                purchasePrice: purchasePrice,
                termLength: termLength,
            }));
        }
        else
        {
            $('#error').html("Please fill out all values");
        }
    })

    $('#nav-bills-tab').click(function(){
        $('#bills').empty();
        $.post('http://customs-nui/getlscbills', JSON.stringify({}));
    })


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
        
        if(item.error != null)
        {
            $('#error').html(item.error)
        }

        if(item.firstname != null)
        {
            $('#bills').append(
                "<tr>" +
                    "<td>" + item.firstname + " " + item.lastname + "</td>" +
                    "<td>" + item.employeefirstname + " " + item.employeelastname + "</td>" +
                    "<td>" + item.amount + "</td>" +
                    "<td>" + item.termlength + "</td>" +
                    "<td>" + item.daysoverdue + "</td>" +
                "</tr>"
            );
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