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
        getresetactivetrials();
    });

    $('#active-trials').on('click', '.activate', function(){
        console.log("activating trial")
        var track = $(this).data('track');
        var model = $(this).data('model');

        $.post('http://racing-nui/activatetrial', JSON.stringify({
            track:track,
            model:model,
        }));
        getresetactivetrials();
    });

    $('#active-trials').on('click', '.deactivate', function(){
        var track = $(this).data('track');
        var model = $(this).data('model');

        $.post('http://racing-nui/deactivatetrial', JSON.stringify({
            track:track,
            model:model,
        }));
        getresetactivetrials();
    })

    $('#active-trials').on('click', '.delete', function(){
        var track = $(this).data('track');
        var model = $(this).data('model');

        $.post('http://racing-nui/deletetrial', JSON.stringify({
            track:track,
            model:model,
        }));
        getresetactivetrials();
    })

    function getresetactivetrials()
    {
        $('#allVehicles').empty().append($('<option>', { 
            value: '',
            text : "Model"
        }));

        $('#allTracks').empty().append($('<option>', { 
            value: '',
            text : "Track"
        }));

        $('#active-trials').empty();
        $.post('http://racing-nui/getactivetrials', JSON.stringify({}));
    }

    function getresettrackinfo(track)
    {
        $('#' + track).empty();

        $.post('http://racing-nui/gettrackinfo', JSON.stringify({
            track:track,
        }));
    }

    var model = '';
    $('#allVehicles').change(function(){
        model = $(this).val();
    });

    var track = ''
    $('#allTracks').change(function(){
        track = $(this).val();
    });

    $('#create-trial').click(function(){
        var laps = $('#laps').val();
        if(track == '')
        {
            $('#create-error').empty().append("Please select a track");
        }
        else if(model == '')
        {
            $('#create-error').empty().append("Please select a model");
        }
        else if(laps == '')
        {
            $('#create-error').empty().append("Please enter number of laps");
        }
        else
        {
            $.post('http://racing-nui/createtrial', JSON.stringify({
                track:track,
                model:model,
                laps:laps
            }));
        }
        getresetactivetrials()
        $('#laps').val('');
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

        if(item.addtovehicledropdown)
        {
            $('#allVehicles').append($('<option>', { 
                value: item.model,
                text : item.name 
            }));
        }

        if(item.addtotrackdropdown)
        {
            $('#allTracks').append($('<option>', { 
                value: item.track,
                text : item.track[0].toUpperCase() + item.track.slice(1)
            }));
        }

        if(item.setupvehicletable)
        {
            var id = item.track;
            console.log("creating table")
            $('#' + id).append("<div class=\"trial-content\" style=\"margin-bottom:10px;\">"+
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
            console.log("adding time")
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
                                                        "<th class=\"col-3\"></th>"+
                                                        "<th class=\"col-2\">Prize Pool</th>"+
                                                        "<th class=\"col-2\">Laps</th>"+
                                                        "<th class=\"col-2\">Status</th>"+
                                                        "<th class=\"col-3\"></th>"+
                                                        "<th class=\"col-3\"></th>"+
                                                    "</tr>"+
                                                "</thead>"+
                                                "<tbody id=\""+ track +"-admin\">"+

                                                "</tbody>"+
                                            "</table"+
                                        "</div>");
        }

        if(item.addtotracktable)
        {
            var id = item.track;
            var active = '';
            if(item.active == 1)
            {
                active = "<td style=\"color:green\">ACTIVE</td>";
            }
            else
            {
                active = "<td style=\"color:red\">INACTIVE</td>";
            }

            var deletes = "<td><button class=\"btn delete\" data-track=\""+ item.track +"\" data-model=\""+ item.model +"\">DELETE</button></td>";

            var buttons = "<button class=\"btn activate\" data-track=\""+ item.track +"\" data-model=\""+ item.model +"\">ACTIVATE</button><button class=\"btn deactivate\" data-track=\""+ item.track +"\" data-model=\""+ item.model +"\">DEACTIVATE</button>"

            $('#' + id + '-admin').append("<tr><td>" + item.name + "</td><td>"+ item.prizepool +"</td><td>"+ item.laps +"</td>"+ active +"<td>"+ buttons +"</td>"+ deletes +"</tr>");
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