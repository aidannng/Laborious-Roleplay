$(function () {
    display(false)
    function display(bool) {
        if (bool) {
            $.post('http://racing-nui/checkjob', JSON.stringify({}));
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }
    
    $('#nav-gokart-tab').click(function(){
        $('#gokart').empty();
        getresettrackinfo("gokart");
    });

    $('#nav-underground-tab').click(function(){
        $('#underground').empty();
        getresettrackinfo("underground");
    });

    $('#nav-management-tab').click(function(){
        $('#active-trials').empty();
        $.post('http://racing-nui/getactivetrials', JSON.stringify({}));
    });

    function getresettrackinfo(track)
    {
        $('#' + track + '-error').empty();
        $('#' + track).empty();

        $('#gokartVehicles').empty().append($('<option>', { 
            text : "Model"
        }));

        $('#undergroundVehicles').empty().append($('<option>', { 
            text : "Model"
        }));

        $.post('http://racing-nui/gettrackinfo', JSON.stringify({
            track:track,
        }));

        $('#' + track + 'LuckyNumber').val('');
        $('#' + track + 'Minutes').val(0);
        $('#' + track + 'Seconds').val(0);
        $('#' + track + 'Milliseconds').val(0);
    }

    var model = '';
    $('#gokartVehicles').change(function(){
        model = $(this).val();
    });

    $('#undergroundVehicles').change(function(){
        model = $(this).val();
    });

    $('.create').click(function(){
        var track = $(this).data("track");

        var luckynumber = $('#'+ track +'LuckyNumber').val();
        var minutes = $('#'+ track +'Minutes').val();
        var seconds = $('#'+ track +'Seconds').val();
        var milliseconds = $('#'+ track +'Milliseconds').val();

        if(luckynumber == '')
        {
            $('#'+ track +'-error').empty().append("Please enter a lucky number");
        }
        else if(model == '')
        {
            $('#'+ track +'-error').empty().append("Please select a model");
        }
        else if(minutes == 0 && seconds == 0 && milliseconds == 0)
        {
            $('#'+ track +'-error').empty().append("Please enter a valid time");
        }
        else
        {
            $.post('http://racing-nui/createtrial', JSON.stringify({
                track:track,
                luckyNumber:luckynumber,
                model:model,
                minutes:minutes,
                seconds:seconds,
                milliseconds:milliseconds,
            }));
    
            getresettrackinfo(track)
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

        if(item.error)
        {
            var id = item.track + "-error";
            $('#' + id).empty().append(item.text);
        }

        if(item.addtodropdown)
        {
            $('#' + item.track + 'Vehicles').append($('<option>', { 
                value: item.model,
                text : item.name 
            }));
        }

        if(item.setupvehicletable)
        {
            var id = item.track;
            $('#' + id).append("<div class=\"trial-content\">"+
                                    "<h3  class=\"color-blue text-align-center display-inline-block\">"+ item.name +"</h3>"+
                                    "<table class=\"table\">"+
                                        "<thead>"+
                                            "<tr>"+
                                                "<th></th>"+
                                                "<th>Name</th>"+
                                                "<th>Time</th>"+
                                            "</tr>"+
                                        "</thead>"+
                                        "<tbody id=\""+ item.model +"\">"+

                                        "</tbody>"+
                                    "</table"+
                                "</div>");
            
        }

        if(item.addtomodel)
        {
            var id = item.model;
            var minutes = item.minutes.toString();
            var seconds = item.seconds.toString();
            var milliseconds = item.milliseconds.toString();
            if(minutes.length == 1)
            {
                minutes = "0" + minutes;
            }
            if(seconds.length == 1)
            {
                seconds = "0" + seconds;
            }
            if(milliseconds.length == 1)
            {
                milliseconds = "0" + milliseconds;
            }

            $('#' + id).append("<tr>"+
                                    "<td>" + item.place + "</td>"+
                                    "<td>"+ item.firstname + " " + item.lastname +"</td>" +
                                    "<td>"+ minutes + ":" + seconds + "." + milliseconds + "</td>"+
                                "</tr>");
        }

        if(item.setuptracktable)
        {
            var track = item.track;
            $('#active-trials').append("<div class=\"trial-content\">"+
                                            "<h3  class=\"color-blue text-align-center display-inline-block\">"+ track[0].toUpperCase() + track.slice(1) +"</h3>"+
                                            "<table class=\"table\">"+
                                                "<thead>"+
                                                    "<tr>"+
                                                        "<th></th>"+
                                                    "</tr>"+
                                                "</thead>"+
                                                "<tbody id=\""+ item.track +"\">"+

                                                "</tbody>"+
                                            "</table"+
                                        "</div>");
        }

        if(item.addtotracktable)
        {
            var track = item.track;
            $('#' + track).append("<tr><td>" + item.name + "</td></tr>");
        }

        if(item.hide == true)
        {
            $('#gokartform').css('display', 'none');
            $('#undergroundform').css('display', 'none');
            $('#nav-management-tab').css('display', 'none');
        }
        else if(item.hide == false)
        {
            $('#gokartform').css('display', 'inherit');
            $('#undergroundform').css('display', 'inherit');
            $('#nav-management-tab').css('display', 'inherit');
        }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            resetUI()

            $.post('http://racing-nui/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        resetUI()

        $.post('http://racing-nui/exit', JSON.stringify({}));
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