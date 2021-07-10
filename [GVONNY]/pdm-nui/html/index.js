$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    $('#nav-purchase-tab').click(function () {
        $('#purchaseAccordian').empty();
        $.post('http://pdm-nui/getallvehicles', JSON.stringify({}));
    });

    $('#nav-stock-tab').click(function(){
        $('#stock').empty();
        $.post('http://pdm-nui/getallstock', JSON.stringify({}));
    });

    $('#nav-showroom-tab').click(function(){
        $.post('http://pdm-nui/getshowroom', JSON.stringify({}));
    });

    $('#nav-bills-tab').click(function(){
        $('#bills').empty();
        $.post('http://pdm-nui/getbills', JSON.stringify({}));
    });


    $('#categories').change(function(){
        var category = $(this).val().toLowerCase();
        $('#models').empty();
        $.post('http://pdm-nui/getvehiclemodels', JSON.stringify({
            category:category,
        }));
    });

    
    $(".accordion").on("click", ".buy", function (){
        console.log("buying")
        var id = this.id;
        var price = $(this).data('price');
        console.log(id);
        console.log(price);
        $.post('http://pdm-nui/purchase', JSON.stringify({
            model:id,
            price:price, 
        }));
    });  
    
    $("#stock").on("click", ".move-to-showroom", function (){
        var plate = $(this).data('plate');
        var slot = $('#' + plate).val();
        $.post('http://pdm-nui/movetoshowroom', JSON.stringify({
            slot:slot,
            plate:plate,
        }));
    }); 

    $(".showroom-slot").on("click", ".remove-showroom", function (){
        var id = $(this).data('slot');
        $('#slot-' + id).empty().html("<span><strong>"+ id +". </strong></span>")

        $.post('http://pdm-nui/removefromshowroom', JSON.stringify({
            showroomslot:id,
        }));
    }); 

    $('#create-bill').click(function () {
        var luckyNumber = $('#luckyNumber').val();
        var plateNumber = $('#plateNumber').val();
        var purchasePrice = $('#purchasePrice').val();
        var termLength = $('#termLength').val();
        if(luckyNumber != '' && plateNumber != '' && purchasePrice != '' && termLength != '')
        {
            $('#error').empty();
            $('#bills').empty();

            $('#luckyNumber').val('');
            $('#plateNumber').val('');
            $('#purchasePrice').val('');
            $('#termLength').val('');
            
            $.post('http://pdm-nui/createbill', JSON.stringify({
                luckyNumber:luckyNumber,
                plateNumber: plateNumber,
                purchasePrice: purchasePrice,
                termLength: termLength,
            }));
        }
        else
        {
            $('#error').html("Please fill out all values");
        }
    });

    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }

        //purchase tab
        if(item.category != null)
        {
            var category = item.category[0].toUpperCase() + item.category.substring(1)
            $('#purchaseAccordian').append(
                "<div class=\"accordion-item\">" +
                    "<h2 class=\"accordion-header\" id=\"heading" + item.index + "\">" +
                        "<button class=\"accordion-button collapsed\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#collapse"+ item.index +"\" aria-expanded=\"true\" aria-controls=\"collapse"+ item.index +"\">" +
                            category +
                        "</button>" +
                    "</h2>" +
                    "<div id=\"collapse"+ item.index +"\" class=\"accordion-collapse collapse\" aria-labelledby=\"headingOne\" data-bs-parent=\"#purchaseAccordian\">" +
                        "<div class=\"accordion-body overflow-auto\">" +
                            "<table class=\"table\">" +
                                "<thead>" +
                                    "<tr>" +
                                        "<th><strong>Model</strong></th>" +
                                        "<th><strong>Price</strong></th>" +
                                        "<th></th>" +
                                    "</tr>" +
                                "</thead>" +
                                "<tbody id=\""+ item.category +"\">" +

                                "</tbody>" +
                            "</table>" +
                        "</div>"+
                    "</div>" +
                "</div>"
            );
        }
        if(item.subcategory != null)
        {
            var id = item.subcategory.toLowerCase();
            $('#' + id).append(
                "<tr>" +
                    "<td>" + item.name + "</td>" +
                    "<td>$" + item.price.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') + "</td>" +
                    "<td><button class=\"btn buy\" id=\""+ item.model +"\" data-price=\""+ item.price +"\">BUY</button></td>" +
                "</tr>"
            );
        }

        //stock tab
        if(item.stockmodel != null)
        {
            console.log(item.stockmodel)
            var str = "<tr>" +
                "<td class=\"text-align-center\">" + item.stockmodel + "</td>" +
                "<td class=\"text-align-center\">" + item.plate + "</td>" +
                "<td class=\"text-align-center\">$" + item.resellprice.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') + "</td>" +
                "<td class=\"text-align-center\">$" + item.finance.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') + "</td>" ;

            if(item.canshowcar)
            {
                str = str + "<td class=\"text-align-center\">" +
                                "<select id=\""+ item.plate +"\">" +
                                    "<option value=\"1\">1</option value=\"2\"><option>2</option><option value=\"3\">3</option><option value=\"4\">4</option><option value=\"5\">5</option><option value=\"6\">6</option><option value=\"7\">7</option>" +
                                "</select>" + 
                                "<button class=\"btn margin-left-10 move-to-showroom\" data-plate=\""+ item.plate +"\">Move to floor</button>" + 
                            "</td>";

                $('#showroom-header').html("<strong>Showroom Management</strong>");
            }
            else
            {
                str = str + "<td></td>";
                $('#showroom-header').html('');
            }

            str = str + "</tr>";

            $('#stock').append(str);
        }

        //showroom tab
        if(item.showroomslot != null)
        {
            var id = item.showroomslot;
            $('#slot-' + id).empty();
            $('#slot-' + id).append("<span><strong>"+ item.showroomslot +". </strong></span><span>"+ item.showroommodel +"</span><span class=\"margin-left-10pct\">"+ item.showroomplate +"</span><span class=\"margin-left-10pct\"><button class=\"btn remove-showroom\" data-slot="+ item.showroomslot +">Remove from floor</button></span>")
        }
        else
        {
            for(var x = 1; x < 8; x++)
            {
                $('#slot-' + x).empty();
                $('#slot-' + x).append("<span><strong>"+ x +".</strong>");
            }
        }

        //billing tab
        if (item.carddeclined) {
            $('#card-declined').html("Card declined");
        }
        else {
            $('#card-declined').empty();
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

        if(item.error != null)
        {
            $('#error').html(item.error)
        }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            resetUI()

            $.post('http://pdm-nui/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        resetUI()

        $.post('http://pdm-nui/exit', JSON.stringify({}));
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