$(function () {
    display(false)

    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
        
        if(item.id != null)
        {
            var str = "<tr id=\"" + item.id + "\"><td>" + item.id + "</td>";

            if(item.target == "society_cardealer")
            {
                str = str + "<td>PDM</td>"
            }
            else if(item.target == "society_police")
            {
                str = str + "<td>LSPD</td>"
            }
            else if(item.target == "society_mechanic")
            {
                str = str + "<td>LS Customs</td>"
            }
            else
            {
                str = str + "<td>" + item.firstname + " " + item.lastname + "</td>"
            }

            str = str + "<td>" + item.label + "</td><td class=\"text-align-center\">$" + item.amount.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') + "</td><td class=\"text-align-center\">"+ item.termlength +"</td><td class=\"text-align-center\">"+ item.termdaysleft +"</td><td id=\""+ item.id +"-amount\" class=\"text-align-center\" data-amount=\""+ item.termamount +"\">$"+ item.termamount.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') +"</td></tr>";

            $('#bills').append(str);
        }

        if(item.error != null)
        {
            $('#error').html(item.error);
        }
    })

    $('#pay').click(function(){
        var billID = $('#billID').val()
        var billAmount = parseInt($('#billAmount').val());

        if(billID != '' && billAmount != '')
        {
            var exists = false;
            $('tr').each(function(){
                if(billID == this.id)
                {
                    exists = true;
                }
            });

            if(exists)
            {
                var id = billID + '-amount'
                var amount = parseInt($('#' + id).data('amount'));
                if(billAmount <= amount)
                {
                    $('#bills').empty();
                    $('#billID').val('');
                    $('#billAmount').val('');
                    $('#error').empty();
                    $.post('http://billing-nui/updatebill', JSON.stringify({
                        billid: billID,
                        billamount: billAmount
                    }));
                }
                else
                {
                    $('#error').empty().html('Value entered is greater than what is owed.');
                }
            }
            else{
                $('#error').empty().html('That bill ID is not associated with your account.');
            }
            return
        }
        else
        {
            $('#error').empty().html('Please fill out all fields.');
        }
    })

    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            resetUI()

            $.post('http://billing-nui/exit', JSON.stringify({}));
            return
        }
    };

    $("#close").click(function () {
        resetUI()

        $.post('http://billing-nui/exit', JSON.stringify({}));
        return
    })

    function resetUI()
    {
        $('#bills').empty();
        $('#billID').val('');
        $('#billAmount').val('');
        $('#error').empty();

        $('.accordion-button').each(function(){
            $(this).addClass('collapsed').attr('area-expanded', false)
        });
		
		$('.accordion-collapse').each(function(){
            $(this).addClass('collapse').removeClass('show')
        });
    }
})