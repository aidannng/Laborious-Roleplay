$(function () {
    display(false)
    function display(bool) {
        if (bool) {
            $("#container").show();
            $('#purchasePrice').val('');
        } else {
            $("#container").hide();
        }
    }
    
    var price = 0;
    $('.image-container').click(function(){
        var cost = parseInt($(this).data('price'));
        price = price + cost;

        $('#purchasePrice').val(price);
    })


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

    $('#nav-boss-tab').click(function(){
        for(var x = 0; x < 6; x++)
        {
            $('#grade-' + x).empty();
        }
        $.post('http://customs-nui/getbossinfo', JSON.stringify({}));
    });


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

    $('.employee').on('click', '.promote', function(){
        var identifier = $(this).data('identifier');
        var grade = $(this).data('grade');

        $.post('http://customs-nui/lscpromote', JSON.stringify({
            identifier:identifier,
            grade:grade,
        }));

        resetManagement()
    });

    $('.employee').on('click', '.demote', function(){
        var identifier = $(this).data('identifier');
        var grade = $(this).data('grade');

        $.post('http://customs-nui/lscdemote', JSON.stringify({
            identifier:identifier,
            grade:grade,
        }));

        resetManagement()
    });

    $('.employee').on('click', '.refresh', function(){
        var identifier = $(this).data('identifier');
        var grade = $(this).data('grade');

        $.post('http://customs-nui/lscrefresh', JSON.stringify({
            identifier:identifier,
            grade:grade,
        }));

        resetManagement()
    });

    $('.employee').on('click', '.fire', function(){
        var identifier = $(this).data('identifier');

        $.post('http://customs-nui/lscfire', JSON.stringify({
            identifier:identifier,
        }));

        resetManagement()
    });

    $('.employee').on('click', '.pay', function(){
        var identifier = $(this).data('identifier');
        var amount = $(this).prev().val();
        $.post('http://customs-nui/lscpay', JSON.stringify({
            identifier:identifier,
            amount:amount
        }));
        $(this).prev().val('');
        resetManagement()
    });

    $('#hire').click(function(){
        var id = $('#hireNumber').val();
        $('#hireNumber').val('');
        $.post('http://customs-nui/lschire', JSON.stringify({
            luckynumber:id,
        }));
        resetManagement()
    })

    $('#deposit').click(function(){
        var amount = $('#bankamount').val();
        $.post('http://customs-nui/lscdeposit', JSON.stringify({
            amount:amount,
        }));
        resetManagement()
    })

    $('#withdraw').click(function(){
        var amount = $('#bankamount').val();
        $.post('http://customs-nui/lscwithdraw', JSON.stringify({
            amount:amount,
        }));
        resetManagement()
    })

    function resetManagement()
    {
        $('#bankamount').val('');
        for(var x = 0; x < 6; x++)
        {
            $('#grade-' + x).empty();
        }
        $.post('http://customs-nui/getbossinfo', JSON.stringify({}));
    }


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

        if(item.jobgrade != null)
        {
            var id = item.jobgrade;
            console.log(id)

            var str = "<tr id=\""+ item.identifier +"\"><td>"+ item.employeefirstname + " " + item.employeelastname +"</td><td><button class=\"btn refresh margin-left-5\" data-grade=\""+ item.jobgrade +"\" data-identifier=\""+ item.identifier +"\">Refresh</button></td>";

            if(item.isowner)
            {
                str = str + "<td><input type=\"number\" placeholder=\"Amount\" id=\"pay-"+ item.identifier +"\"/><button class=\"btn pay margin-left-5\" data-identifier=\""+ item.identifier +"\">Pay</button></td>" +
                            "<td><button class=\"btn promote margin-left-5\" data-grade=\""+ item.jobgrade +"\" data-identifier=\""+ item.identifier +"\">Promote</button><button class=\"btn demote margin-left-5\" data-grade=\""+ item.jobgrade +"\" data-identifier=\""+ item.identifier +"\">Demote</button></td>" +
                            "<td><button class=\"btn fire margin-left-5\" data-identifier=\""+ item.identifier +"\">Fire</button></td>"
            }
            else
            {
                str = str + "<td></td><td></td><td></td>";
            }

            str = str + "</tr>";
            $('#grade-' + id).append(str)
            
            if(item.isowner)
            {
                console.log("is owner")
                console.log(item.balance)
                $('#account-balance').empty().html("$" + item.balance.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,'));
                $('#owner-info').attr('hidden', false);
            }
            else
            {
                console.log("not owner")
                $('#owner-info').attr('hidden', true);
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