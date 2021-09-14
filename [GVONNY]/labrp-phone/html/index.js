$(function () {
    var numberFromMessages = '';
    var isOpen = false;
    var gettingCalled = false;
    
    display(false);
    function display(bool) {
        if (bool) {
            console.log("opening phone")

            hideApps();

            if(!isOpen && !gettingCalled)
            {
                showApp("lockscreen");
                getNotifications();
            }

            $(".mobile").show();
            isOpen = true
        } else {
            isOpen = false
            gettingCalled = false;
            $('.nav-link').removeClass('active').attr('aria-selected', false);
            $('.tab-pane').removeClass('active').removeClass('show');
            $(".mobile").hide();
        }
    }

    function getNotifications()
    {
        $('#nav-tab').empty();
        $('#nav-tabContent').empty();
        $.post('http://labrp-phone/get-notifications', JSON.stringify({}));
    }

    function clearNotification(app)
    {
        $.post('http://labrp-phone/clear-notifications', JSON.stringify({
            app:app
        }));
    }

    $('.carousel').carousel({
        interval: 5000
    })

    $('.navigation-back-button').click(function(){
        if($(this).data('app') != undefined)
        {
            swapToApp($(this).data('app'));
            if($(this).data('app') == "contacts")
            {
                numberFromMessages = '';
            }
        }
    })

    $('.navigation-create-button').click(function(){
        swapToApp($(this).data('app'));
    });

    $('.navigation-refresh-button').click(function(){
        showApp($(this).data('app'));
    });

    $('.bottom-bar-tab').click(function(){
        if($(this).data('app') != undefined)
        {
            swapToApp($(this).data('app'));
        }
    })


    $('input[type=text], textarea').focus(function(){
        $.post('http://labrp-phone/set-input-focus', JSON.stringify({
            focus:true,
        }));
    })

    $('input[type=text], textarea').focusout(function(){
        $.post('http://labrp-phone/set-input-focus', JSON.stringify({
            focus:false,
        }));
    })

    //#region Lock Screen
    $('#nav-tabContent').on('click', '.clear-notification', function(){
        var id = $(this).data('id');

        $.post('http://labrp-phone/clear-notification', JSON.stringify({
            id:id
        }));

        setTimeout(getNotifications, 100)
    })

    $('#nav-tabContent').on('click', '.notification-bubble', function(){
        var id = $(this).data('id');
        console.log(id)

        if($(this).data('app') == "ping")
        {
            $.post('http://labrp-phone/accept-ping', JSON.stringify({
                id:id
            }));

            $(this).remove();
            setTimeout(getNotifications, 100)
        }
        else
        {
            swapToApp($(this).data('app'));
        }
        $.post('http://labrp-phone/set-phone-active', JSON.stringify({}));
        
    })

    $('.mobile').click(function(){
        $.post('http://labrp-phone/set-phone-active', JSON.stringify({}));
    })
    //#endregion

    //#region Home Screen
    $('.bottom').click(function () {
        hideAppHelper();
        showAppsHelper();

        $('#edit-note-text').val('');

        $.post('http://labrp-phone/set-phone-active', JSON.stringify({}));
        $.post('http://labrp-phone/end-call', JSON.stringify({}));
    })

    $('.top').click(function(){
        resetUI();

        $.post('http://labrp-phone/exit', JSON.stringify({}));        
        $.post('http://labrp-phone/end-call', JSON.stringify({}));
    })

    $('#home-screen').on('click', '.icon', function () {
        hideAppsHelper();
        showAppHelper($(this).data('app'));
    });

    $('#home-screen').on('click', '.custom-icon', function () {
        hideAppsHelper();
        showAppHelper($(this).data('app'));
    });

    function swapToApp(app){
        hideApp();
        showApp(app);
    }
    function hideAppsHelper(){
        $('.apps').fadeOut("fast")
        setTimeout(hideApps, 180);
    }
    function showAppsHelper(){
        setTimeout(showApps, 250);
    }
    function hideAppHelper() {
        $('.app').fadeOut("fast");
        setTimeout(hideApp, 180);
    }
    function showAppHelper(app){
        setTimeout(showApp, 250, app);
    }

    function hideApps() {
        $('.apps').css('visibility', 'hidden').css('display', 'none').removeClass('d-flex');
    }
    function showApps() {
        $.post('http://labrp-phone/check-if-boss', JSON.stringify({}));
        $('.apps').css('visibility', 'visible').css('display', 'flex').addClass('d-flex');
    }
    function hideApp() {
        $('.app').css('visibility', 'hidden').css('display', 'none').removeClass('d-flex');
    }
    function showApp(app) {
        if(app == "phone")
        {
            clearNotification("phone")
            $('.phone-call-number').empty();
            showContent(app);
        }
        else if(app == "contacts")
        {
            $('#contact-list').empty();
            $.post('http://labrp-phone/get-contacts', JSON.stringify({}));
            setTimeout(showContent, 200, app);
        }
        else if(app == "create-contact")
        {
            $('#new-contact-name').val('');
            $('#new-contact-name').css('border-bottom-color', 'rgba(0, 0, 0, 0.555)');

            if(numberFromMessages == '')
            {
                $('#new-contact-number').val('');
            }
            else
            {
                $('#new-contact-number').val(numberFromMessages);
            }
            $('#new-contact-number').css('border-bottom-color', 'rgba(0, 0, 0, 0.555)');
            
            $('#new-contact-add').removeClass("spinner-border").html("Add Contact");
            showContent(app);
        }
        else if(app == "vehicles")
        {
            $('#vehicle-list').empty();
            $.post('http://labrp-phone/get-vehicles', JSON.stringify({}));
            setTimeout(showContent, 200, app);
        }
        else if(app == "messages")
        {
            clearNotification("messages")
            $('#message-list').empty();
            $.post('http://labrp-phone/get-messages', JSON.stringify({}));
            setTimeout(showContent, 200, app);
        }
        else if(app == "info")
        {
            $('#personal-phone-number').empty();
            $('#personal-licenses').empty();
            $('#personal-bank-accounts').empty();
            $.post('http://labrp-phone/get-personal-info', JSON.stringify({}));
            
            setTimeout(showContent, 200, app);
        }
        else if(app == "twitter")
        {
            clearNotification("twitter")
            $('#tweet-list').empty();
            $.post('http://labrp-phone/get-tweets', JSON.stringify({}));
            setTimeout(showContent, 200, app);
        }
        else if(app == "new-tweet")
        {
            $('#new-tweet').val('')
            $('#tweet-add').removeClass("spinner-border").html("Tweet");
            showContent(app);
        }
        else if(app == "yellow-pages")
        {
            $('#yellow-pages-ad-list').empty();
            $.post('http://labrp-phone/get-yellow-pages', JSON.stringify({}));
            setTimeout(showContent, 200, app);
        }
        else if(app == "new-yellow-page")
        {
            $('#new-yellow-page-ad').val('');
            $('#yellow-pages-add').removeClass("spinner-border").html("Post");
            showContent(app);
        }
        else if(app == "ping")
        {
            $('#ping-number').val('');
            $('#ping-player').removeClass("spinner-border").html("Ping");
            showContent(app);
        }
        else if(app == "boss-menu")
        {
            $('#employee-list').empty();
            $.post('http://labrp-phone/get-boss-menu', JSON.stringify({}));
            showContent(app);
        }
        else if(app == "boss-menu-hire")
        {
            $('#hire-number').css('border-bottom-color', 'rgba(0, 0, 0, 0.555)');
            $('#hire-number').val('');
            $('#hire-player').removeClass("spinner-border").html("Hire");
            showContent(app);
        }
        else if(app == "multi-job")
        {
            $('#multi-job-list').empty();
            $('#multi-job-list .hint').tooltip();
            $.post('http://labrp-phone/get-multi-jobs', JSON.stringify({}));

            showContent(app);
        }
        else if(app == "notes")
        {
            $('#notes-list').empty();
            $.post('http://labrp-phone/get-notes', JSON.stringify({}));
            showContent(app);
        }
        else if(app == "new-note")
        {
            $('#new-note-title').css('border-bottom-color', 'rgba(0, 0, 0, 0.555)');
            showContent(app);
        }
        else if(app == "call-history")
        {
            $('#call-history-list').empty();
            $.post('http://labrp-phone/get-call-history', JSON.stringify({}));
            showContent(app);

        }
        else if(app == "contact-favorites")
        {
            $('#contact-favorite-list').empty();
            $.post('http://labrp-phone/get-favorite-contacts', JSON.stringify({}));
            showContent(app);
        }
        else if(app == "lsc")
        {
            $('.carousel').carousel({
                interval: 5000
            })
            showContent(app);
        }
        else
        {
            showContent(app);
        }
    }

    function showContent(app)
    {
        $('.' + app).css('visibility', 'visible').css('display', 'flex').addClass('d-flex');
    }
    //#endregion

    //#region Phone App
    $('.phone-keypad-button').click(function () {
        var num = parseInt($(this).html());

        var number = $('.phone-call-number').html();
        if (number.length < 7) {
            $('.phone-call-number').append(num);
        }
    });


    $('.phone-keypad-clear-button').click(function () {
        $('.phone-call-number').empty();
    });

    $('.call-number').click(function(){
        var number = $('.phone-call-number').html();
        swapToApp($(this).data('app'));
        $('.calling').empty().html('Calling.');
        $.post('http://labrp-phone/start-call', JSON.stringify({
            number:number
        }));
    })

    $('.phone-end-call-button').click(function(){
        hideApp();
        showAppsHelper();
        $.post('http://labrp-phone/end-call', JSON.stringify({}));

        $.post('http://labrp-phone/set-phone-active', JSON.stringify({}));
    })

    $('.phone-accept-call-button').click(function(){
        var number = $(this).data('number');
        console.log(number);
        swapToApp($(this).data('app'));
        $.post('http://labrp-phone/call-accepted', JSON.stringify({
            number:number
        }));
        gettingCalled = false;

        $.post('http://labrp-phone/set-phone-active', JSON.stringify({}));
    })

    $('#call-history-list').on('click', '.call-history', function(){
        var number = $(this).data('number');
        swapToApp($(this).data('app'));
        $('.calling').empty().html('Calling.');
        $.post('http://labrp-phone/start-call', JSON.stringify({
            number:number
        }));
    })

    $('#contact-favorite-list').on('click', '.favorite-contact', function(){
        var number = $(this).data('number');
        swapToApp($(this).data('app'));
        $('.calling').empty().html('Calling.');
        $.post('http://labrp-phone/start-call', JSON.stringify({
            number:number
        }));
    })
    //#endregion

    //#region Contacts App
    $('.contact-list-create-button').click(function(){
        swapToApp($(this).data('app'));
    });

    $('#new-contact-add').click(function(){
        var validName = false;
        var validNumber = false;
        var name = $('#new-contact-name').val();
        if(name != '')
        {
            validName = true;
            $('#new-contact-name').css('border-bottom-color', 'rgba(0, 0, 0, 0.555)');
        }
        else
        {
            $('#new-contact-name').css('border-bottom-color', 'red');
        }

        var number = $('#new-contact-number').val();
        if(number != '')
        {
            if(!numberHasLetters(number))
            {
                validNumber = true;            
                $('#new-contact-number').css('border-bottom-color', 'rgba(0, 0, 0, 0.555)');
            }
            else
            {            
                $('#new-contact-number').css('border-bottom-color', 'red');
            }
        }
        else
        {
            $('#new-contact-number').css('border-bottom-color', 'red');
        }

        if(validName && validNumber)
        {
            $.post('http://labrp-phone/add-contact', JSON.stringify({
                name:name,
                number:number,
            }));
            
            $(this).empty().addClass("spinner-border");
            setTimeout(swapToApp, 1000, $(this).data('app'));
        }
    });

    $('#contact-list').on('click', '.view-contact-details', function(){
        var number = $(this).data('number');
        var name = $(this).data('name');

        $('#contact-info-name').empty().html(name);
        $('#contact-info-number').empty().html(number);
        
        var favorite = "";
        if(Boolean($(this).data('favorite')))
        {
            favorite = "<div class=\"circle-button margin-left-10px\"><i class=\"fa fa-star padding-top-12px favorite-contact color-gold\" data-number=\""+ number +"\" data-favorite=\""+ Boolean($(this).data('favorite')) +"\"></i></div>";
        }
        else
        {
            favorite = "<div class=\"circle-button margin-left-10px\"><i class=\"fa fa-star padding-top-12px favorite-contact\" data-number=\""+ number +"\" data-favorite=\""+ Boolean($(this).data('favorite')) +"\"></i></div>";
        }
        $('#contact-info').empty().append("<div>"+
                                                "<h3 class=\"center\">"+ name +"</h3>"+
                                            "</div>"+
                                            "<div class=\"margin-top-25px center\">"+
                                                "<div class=\"circle-button\"><i class=\"fa fa-phone padding-top-15px call-contact\" data-name=\""+ name +"\" data-number=\""+ number +"\" data-app=\"phone-calling\"></i></div>"+
                                                "<div class=\"circle-button margin-left-10px\"><i class=\"fa fa-comments padding-top-12px new-text-message\" data-name=\""+ name +"\" data-number=\""+ number +"\" data-app=\"message-texts\"></i></div>"+
                                                favorite+
                                            "</div>"+
                                            "<div class=\"margin-top-10px center\">"+
                                                "<h4>"+ number +"</h4>"+
                                            "</div>"+
                                            "<hr>"+
                                            "<div>"+
                                                "<h5 class=\"contact-info-link contact-info-share-contact margin-left-10px\" data-number=\""+ number +"\" data-name=\""+ name +"\" data-app=\"contacts\">Share Contact</h5>"+
                                            "</div>"+
                                            "<div>"+
                                                "<h5 class=\"contact-info-link contact-info-share-location margin-left-10px margin-top-10px\" data-number=\""+ number +"\" data-app=\"contacts\">Share Location</h5>"+
                                            "</div>"+
                                            "<div>"+
                                                "<h5 class=\"contact-info-delete margin-left-10px margin-top-10px\" data-number=\""+ number +"\" data-app=\"contacts\">Delete Contact</h5>"+
                                            "</div>");
        swapToApp($(this).data('app'));
    })

    $('#contact-info').on('click', '.favorite-contact', function(){
        var number = $(this).data('number');
        $(this).data('favorite', !Boolean($(this).data('favorite')));
        var isFavorite = Boolean($(this).data('favorite'));
        $.post('http://labrp-phone/favorite-contact', JSON.stringify({
            number:number,
            favorite:isFavorite,
        }));

        $(this).toggleClass('color-gold');
    });

    $('#contact-info').on('click', '.contact-info-delete', function(){
        var number = $(this).data('number');
        $.post('http://labrp-phone/delete-contact', JSON.stringify({
            number:number,
        }));

        $(this).empty().addClass("spinner-border");
        setTimeout(swapToApp, 1000, $(this).data('app'));
    });

    $('#contact-info').on('click', '.contact-info-share-location', function(){
        var number = $(this).data('number');
        $.post('http://labrp-phone/ping-contact', JSON.stringify({
            number:number,
        }));

        $(this).empty().addClass("spinner-border");
        setTimeout(swapToApp, 1000, $(this).data('app'));
    });

    $('#contact-info').on('click', '.contact-info-share-contact', function(){
        var number = $(this).data('number');
        var name = $(this).data('name');
        $.post('http://labrp-phone/share-contact', JSON.stringify({
            number:number,
            name:name,
        }));

        $(this).empty().addClass("spinner-border");
        setTimeout(swapToApp, 1000, $(this).data('app'));
    });

    $('#contact-info').on('click', '.new-text-message', function(){
        var number = $(this).data('number');
        var name = $(this).data('name');

        $('#message-contact').empty().html(name);
        $('#message-text-list').empty();
        $('#new-message-text').val('').data("number", number);

        $.post('http://labrp-phone/get-message-texts', JSON.stringify({
            number:number,
        }));

        swapToApp($(this).data('app'));
        $('#message-text-list').animate({ scrollTop: 999999 }, "slow");
    });

    $('#contact-info').on('click', '.call-contact', function(){
        var number = $(this).data('number');
        swapToApp($(this).data('app'));
        $('.calling').empty().html('Calling.');
        $.post('http://labrp-phone/start-call', JSON.stringify({
            number:number
        }));
    });
    //#endregion

    //#region Messages App
    $('#send-text-message').click(function(){
        console.log($('#new-message-text').val());
        var message = $('#new-message-text').val();
        var number = $('#new-message-text').data('number');

        if(message.trim() != '')
        {
            $.post('http://labrp-phone/send-text-message', JSON.stringify({
                number:number,
                message:message,
            }));
    
            $('#message-text-list').empty();
            $('#new-message-text').val('').data("number", number);
    
            $.post('http://labrp-phone/get-message-texts', JSON.stringify({
                number:number,
            }));
    
            $('#message-text-list').animate({ scrollTop: 999999 }, "slow");
        }
    });

    $('#missing-contact').click(function(){
        var number = $('#message-contact').html().toString();
        numberFromMessages = number;

        swapToApp($(this).data('app'));
    });

    $('#message-list').on('click', '.delete-message', function(){
        var number = $(this).data('number');

        $.post('http://labrp-phone/delete-message-history', JSON.stringify({
            number:number,
        }));

        setTimeout(swapToApp,500,"messages");
    })

    $('#message-list').on('click', '.message', function(){
        var name = $(this).data('name');
        var number = $(this).data('number');
        var isContact = $(this).data('iscontact');

        if(!isContact)
        {
            $('#missing-contact').removeClass('visibility-none');
        }
        else
        {
            $('#missing-contact').addClass('visibility-none');
        }

        $('#message-contact').empty().html(name);
        $('#message-text-list').empty();
        $('#new-message-text').val('').data("number", number);

        $.post('http://labrp-phone/get-message-texts', JSON.stringify({
            number:number,
        }));

        swapToApp($(this).data('app'));
        $('#message-text-list').animate({ scrollTop: 999999 }, "slow");
    });
    //#endregion

    //#region Twitter App
    $('#tweet-add').click(function(){
        var tweet = $('#new-tweet').val();

        if(tweet != '')
        {
            $.post('http://labrp-phone/add-tweet', JSON.stringify({
                tweet:tweet,
            }));
            $(this).empty().addClass("spinner-border");
            setTimeout(swapToApp, 1000, $(this).data('app'));
        }
    });

    $('#tweet-list').on('click', '.twitter-heart', function(){
        var liked = $(this).data('liked')
        var id = $(this).data('tweet-id');
        var likes = parseInt($('#' + id).html())

        if(liked)
        {
            likes = likes - 1;
            $(this).removeClass("tweet-liked").addClass("tweet-unliked");
            $(this).data('liked', false);
            $.post('http://labrp-phone/like-tweet', JSON.stringify({
                liked:false,
                tweet:id,
            }));
        }
        else
        {
            likes = likes + 1;
            $(this).removeClass("tweet-unliked").addClass("tweet-liked");
            $(this).data('liked', true);
            $.post('http://labrp-phone/like-tweet', JSON.stringify({
                liked:true,
                tweet:id,
            }));
        }

        $('#' + id).empty().html(likes);
    });

    $('#tweet-list').on('click', '.delete-tweet', function(){
        var id = $(this).data('tweet');

        $.post('http://labrp-phone/delete-tweet', JSON.stringify({
            tweet:id,
        }));

        showApp("twitter");
    })

    $('#new-tweet').on('keyup', function(){
        var count = 150
        var input = $(this).val();
        var length = input.length;

        $('#tweet-character-count').empty().html(count-length)
    })
    //#endregion

    //#region Yellow Pages App
    $('#yellow-pages-add').click(function(){
        var ad = $('#new-yellow-page-ad').val();

        if(ad != '')
        {
            $.post('http://labrp-phone/add-yellow-pages-ad', JSON.stringify({
                message:ad,
            }));
            $(this).empty().addClass("spinner-border");
            setTimeout(swapToApp, 1000, $(this).data('app'));
        }
    });

    $('#yellow-pages-ad-list').on('click', '.delete-yellow-pages-ad', function(){
        var id = $(this).data('ad');

        $.post('http://labrp-phone/delete-yellow-pages-ad', JSON.stringify({
            ad:id,
        }));

        showApp("yellow-pages");
    })

    $('#yellow-pages-ad-list').on('click', '.new-text-message', function(){
        var number = $(this).data('number');
        var name = $(this).data('name');

        $('#message-text-list').empty();
        $('#new-message-text').val('').data("number", number);

        $.post('http://labrp-phone/get-message-texts', JSON.stringify({
            number:number,
        }));

        $.post('http://labrp-phone/get-contact-from-number', JSON.stringify({
            number:number,
        }));

        swapToApp($(this).data('app'));
        $('#message-text-list').animate({ scrollTop: 999999 }, "slow");
    });

    $('#yellow-pages-ad-list').on('click', '.call-number', function(){
        var number = $(this).data('number');
        swapToApp($(this).data('app'));
        $('.calling').empty().html('Calling.');
        $.post('http://labrp-phone/start-call', JSON.stringify({
            number:number
        }));
    });

    $('#new-yellow-page-ad').on('keyup', function(){
        var count = 150
        var input = $(this).val();
        var length = input.length;

        $('#yellow-pages-character-count').empty().html(count-length)
    })
    //#endregion

    //#region Ping App
    $('#ping-player').click(function(){
        var id = $('#ping-number').val();
        if(id != '' && !numberHasLetters(id))
        {
            $.post('http://labrp-phone/ping-player', JSON.stringify({
                id:id,
            }));
        }
        $(this).empty().addClass("spinner-border");
        $('#ping-number').val('');
        setTimeout(resetPing, 1000)
    });

    function resetPing()
    {
        $('#ping-player').empty().removeClass("spinner-border").html("Ping");

    }
    //#endregion

    //#region Boss Menu App
    $('#employee-list').on('click', '.boss-menu-promote', function(){
        var identifier = $(this).data('identifier');
        var grade = $(this).data('grade');
        var job = $(this).data('job');

        $.post('http://labrp-phone/boss-menu-promote', JSON.stringify({
            identifier:identifier,
            grade:grade+1,
            job:job,
        }));
        swapToApp("boss-menu");
    });

    $('#employee-list').on('click', '.boss-menu-demote', function(){
        var identifier = $(this).data('identifier');
        var grade = $(this).data('grade');
        var job = $(this).data('job');

        if(grade > 0)
        {
            $.post('http://labrp-phone/boss-menu-promote', JSON.stringify({
                identifier:identifier,
                grade:grade-1,
                job:job,
            }));
            swapToApp("boss-menu");
        }
    });

    $('#employee-list').on('click', '.boss-menu-fire', function(){
        var identifier = $(this).data('identifier');
        var job = $(this).data('job');

        $.post('http://labrp-phone/boss-menu-fire', JSON.stringify({
            identifier:identifier,
            job:job,
        }));
        swapToApp("boss-menu");
    });

    $('#hire-player').click(function(){
        var id = $('#hire-number').val();
        console.log(id != '' && !numberHasLetters(id))
        if(id != '' && !numberHasLetters(id))
        {
            $.post('http://labrp-phone/boss-menu-hire', JSON.stringify({
                id:id,
            }));

            $(this).empty().addClass("spinner-border");
            setTimeout(swapToApp, 1000, $(this).data('app'));
            $('#hire-number').css('border-bottom-color', 'rgba(0, 0, 0, 0.555)');
        }
        else
        {
            console.log("error")
            $('#hire-number').css('border-bottom-color', 'red');
        }
    })
    //#endregion

    //#region Multi Job App
    $('#multi-job-list').on('click', '.multi-job-sign-off', function(){
        $.post('http://labrp-phone/multi-job-set-unemployed', JSON.stringify({}));
        $.post('http://labrp-phone/check-if-boss', JSON.stringify({}));

        swapToApp("multi-job")
    })

    $('#multi-job-list').on('click', '.multi-job-sign-on', function(){
        var job = $(this).data('job');
        var grade = $(this).data('grade');
        $.post('http://labrp-phone/multi-job-set-job', JSON.stringify({
            job:job,
            grade:grade,
        }));

        $.post('http://labrp-phone/check-if-boss', JSON.stringify({}));

        swapToApp("multi-job")
    })
    //#endregion

    //#region Notes App
    $('#new-note-back-button').click(function(){
        var title = $('#new-note-title').val();
        var text = $('#new-note-text').val();

        if(text == '')
        {
            swapToApp("notes");
            
            $('#new-note-title').val('');
            $('#new-note-text').val('');
        }
        else
        {
            if(title == '')
            {
                $('#new-note-title').css('border-bottom-color', 'red');
            }
            else
            {
                $('#new-note-title').css('border-bottom-color', 'rgba(0, 0, 0, 0.555)');
               
                $.post('http://labrp-phone/add-note', JSON.stringify({
                    title:title,
                    text:text,
                }));

                hideAppHelper();
                showAppHelper("notes"); 

                $('#new-note-title').val('');
                $('#new-note-text').val('');
            }
        }
    });

    $('#notes-list').on('click', '.share-note', function(){
        var id = $(this).data('id');

        $.post('http://labrp-phone/share-note', JSON.stringify({
            id:id
        }));
    })

    $('#edit-note-back-button').click(function(){
        var id = $(this).data('id');
        var text = $('#edit-note-text').val();

        $.post('http://labrp-phone/update-note', JSON.stringify({
            id:id,
            text:text,
        }));

        $('#edit-note-title').empty();
        $('#edit-note-text').val('');
    })

    $('#notes-list').on('click', '.note', function(){
        var id = $(this).data('id');

        $.post('http://labrp-phone/get-note', JSON.stringify({
            id:id
        }));

        setTimeout(swapToApp,150,$(this).data('app'));
    })

    $('#delete-note').click(function(){
        var id = $(this).data('id')

        $.post('http://labrp-phone/delete-note', JSON.stringify({
            id:id
        }));

        hideAppHelper();
        showAppHelper($(this).data('app'));
    })
    //#endregion

    window.addEventListener('message', function (event) {
        var ui = event.data;
        if (ui.type === "ui") {
            if (ui.status == true) {
                $.post('http://labrp-phone/check-if-boss', JSON.stringify({}));
                setTimeout(display, 200, true)
            } else {
                display(false)
            }
        }

        //Open app by default when phone launches
        if(ui.openApp)
        {
            hideApp();
            hideApps();

            if(ui.app == "incoming-call")
            {
                gettingCalled = true;
            }

            showApp(ui.app);
        }

        //Update status bar time
        if(ui.updateStatusBarTime)
        {
            var minutes
            if(ui.minutes.toString().length == 1)
            {
                minutes = "0" + ui.minutes;
            }
            else
            {
                minutes = ui.minutes;
            }

            var hour
            var ampm
            if(ui.hour >= 12)
            {
                hour = ui.hour - 12;
                ampm = "PM"
            }
            else
            {
                hour = ui.hour
                ampm = "AM"
            }

            if(hour == 0)
            {
                hour = 12;
            }

            $('.time').empty().html(hour + ":" + minutes + " " + ampm)
        }

        //Add contact to contact list
        if(ui.addToContactList)
        {
            var favorite = ""
            if(ui.favorite)
            {
                favorite = "<i class=\"fa fa-star margin-right-5px color-gold\"></i>"
            }
            $('#contact-list').append("<div class=\"app-list-item\">"+
                                            favorite +
                                            "<strong>"+ ui.name +"</strong>"+
                                            "<i class=\"fa fa-chevron-right float-right margin-right-5px margin-top-8px view-contact-details\" data-app=\"contact-info\" data-number=\""+ ui.number +"\" data-name=\""+ ui.name +"\" data-favorite=\""+ ui.favorite +"\"></i>"+
                                        "</div>")
            
        }

        //Add vehicle to vehicle list
        if(ui.addToVehicleList)
        {
            var order = ui.order;
            var garage = ui.garage;
            if(garage == undefined)
            {
                garage = "Out";
            }

            $('#vehicle-list').append("<div class=\"app-list-item height-75px\">"+
                                            "<strong>"+ ui.model +"<span class=\"float-right margin-right-5px allow-highlight\">"+ ui.plate +"</strong><br>"+
                                            "<span class=\"margin-right-5px font-size-16\">Garage: "+ garage +"</span>"+
                                        "</div>");
        }

        //Add message to message list
        if(ui.addToMessageList)
        {
            /* var minutes
            if(ui.minutes.toString().length == 1)
            {
                minutes = "0" + ui.minutes;
            }
            else
            {
                minutes = ui.minutes;
            }

            var hour
            var ampm
            if(ui.hour >= 12)
            {
                hour = ui.hour - 12;
                ampm = "PM"
            }
            else
            {
                hour = ui.hour
                ampm = "AM"
            }

            if(hour == 0)
            {
                hour = 12;
            } */

            var isRead = '';
            /* if(ui.isRead == 0)
            {
                isRead = '<span><i class="far fa-circle margin-left-5px" style="color:lightblue"></i></span>'
            } */
            
            var message = '';
            //var message = ui.message;
            /* if(message.length > 30)
            {
                message = message.substring(0.29) + "...";
            } */
            
            /* if(ui.sent && ui.isRead == 1)
            {
                isRead = '<span><i class="fas fa-share margin-left-5px" style="color:lightblue"></i></span>';
                //message = "You: " + message
            } */

            $('#message-list').append("<div class=\"app-list-item height-75px message\" data-app=\"message-texts\" data-number=\""+ ui.number +"\" data-name=\""+ ui.name +"\" data-iscontact=\""+ ui.isContact +"\">"+
                                            "<strong>"+ ui.name +"</strong>"+ isRead +"<i class=\"fa fa-trash float-right margin-right-5px margin-top-8px delete-message\" data-number=\""+ ui.number +"\"></i><br>"+
                                            /* "<strong>"+ ui.name +"</strong><br>"+ */
                                            "<span class=\"margin-right-5px font-size-16\">"+ message +"</span>"+
                                            "<i class=\"fa fa-chevron-right float-right margin-right-5px margin-top-8px view-message-details\" data-app=\"message-texts\" data-number=\""+ ui.number +"\" data-name=\""+ ui.name +"\" data-iscontact=\""+ ui.isContact +"\"></i>"+
                                        "</div>")
            
        }

        //Add text to text list
        if(ui.addToTextList)
        {
            var order = ui.order;
            if(ui.sender)
            {
                $('#message-text-list').append("<div class=\"text-message-sender margin-top-8px\">"+
                                                    "<span>"+ ui.message +"</span>"+
                                                "</div>");
            }
            else
            {
                $('#message-text-list').append("<div class=\"text-message-receiver margin-top-8px\">"+
                                                    "<span>"+ ui.message +"</span>"+
                                                "</div>");
            }
        }

        //Does the cool .. animation when calling or receiving a call
        if(ui.updateCallingHeader)
        {
            var x = parseInt(ui.x);
            if(x < 3)
            {
                $('.calling').append('.');
                $('.incoming').append('.');
            }
            else
            {
                $('.calling').empty().html('Calling.');
                $('.incoming').empty().html('Incoming Call.');
            }
        }
        if(ui.updateCallingUnavailable)
        {
            $('.calling').empty().html('Unavailable');
            setTimeout(hideAppHelper, 1000);
            setTimeout(showAppsHelper, 1000);
        }

        //Updates person getting called caller ID to contact name
        if(ui.updateCallingContact)
        {
            if(ui.number != undefined)
            {
                $('.phone-accept-call-button').data('number', ui.number);
            }
            
            if(ui.name != undefined)
            {
                $('.phone-call-number').empty().html(ui.name);
            }
            else
            {
                $('.phone-call-number').empty().html(ui.number);
            }
        }

        if(ui.endCall)
        {
            gettingCalled = false;
            hideApp();
            showAppsHelper();
        }

        //Updates info app phone number
        if(ui.updatePersonalPhone)
        {
            $('#personal-phone-number').html(ui.number);
        }

        //Add licesnses to info app
        if(ui.addToLicenses)
        {
            var license = "";
            switch(ui.type)
            {
                case "drive":
                case "dmv":
                case "drive_bike":
                case "drive_truck":
                    license = "<i class=\"fa fa-car margin-left-10px\"></i> "+ ui.label +"<br>";
                    break;
                case "weapon":
                    license = "<i class=\"fa fa-id-card margin-left-10px\"></i> "+ ui.label +"<br>";
                    break;
            }
            $('#personal-licenses').append(license);
        }

        //Add accounts to info app
        if(ui.addToBankAccounts)
        {
            var account = "";
            switch(ui.account)
            {
                case "checking":
                    account = "<i class=\"fa fa-credit-card margin-left-10px\"></i> Checking <span class=\"float-right margin-right-10px\">$" + ui.balance.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') + "</span><br>";
                    break;
                case "savings":
                    account = "<i class=\"fa fa-university margin-left-10px\"></i> Savings <span class=\"float-right margin-right-10px\">$" + ui.balance.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') + "</span><br>";
                    break;
                case "business":
                    account = "<i class=\"fa fa-building margin-left-10px padding-left-2px\"></i> Business <span class=\"float-right margin-right-10px\">$" + ui.balance.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') + "</span><br>";
                    break;
            }

            $('#personal-bank-accounts').append(account);
        }

        //Add paycheck amount to info app
        if(ui.updatePaycheck)
        {
            console.log(ui.amount)
            $('#paycheck-amount').html("$" + ui.amount.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,'));
        }

        //Adds tweet to tweet list
        if(ui.addToTweets)
        {
            var trash = '';
            if(ui.isAdmin)
            {
                trash = "<i class=\"fa fa-trash float-right margin-right-5px margin-top-8px delete-tweet\" data-tweet=\""+ ui.id +"\"></i>";
            }

            if(ui.likedTweet)
            {
                $('#tweet-list').append("<div class=\"border-bottom-grey padding-bottom-5px\">"+
                                            "<div class=\"tweet-handle margin-left-5px\">@"+ ui.handle + trash + "</div>"+
                                            "<div class=\"margin-left-40px\">"+
                                                ui.text+
                                            "</div>"+
                                            "<div class=\"center margin-left-250px\"><span id=\""+ ui.id +"\" class=\"margin-right-5px\">"+ ui.likes +"</span><i class=\"fa fa-heart tweet-liked twitter-heart\" data-liked=\""+ ui.likedTweet +"\" data-tweet-id=\""+ ui.id +"\"></i></div>"+
                                        "</div>");
            }
            else
            {
                $('#tweet-list').append("<div class=\"border-bottom-grey padding-bottom-5px\">"+
                                            "<div class=\"tweet-handle margin-left-5px\">@"+ ui.handle + trash +"</div>"+
                                            "<div class=\"margin-left-40px\">"+
                                                ui.text+
                                            "</div>"+
                                            "<div class=\"center margin-left-250px \"><span id=\""+ ui.id +"\" class=\"margin-right-5px\">"+ ui.likes +"</span><i class=\"fa fa-heart tweet-unliked twitter-heart\" data-liked=\""+ ui.likedTweet +"\" data-tweet-id=\""+ ui.id +"\"></i></div>"+
                                        "</div>");
            }
        }

        //Adds ad to yellow pages app
        if(ui.addToYellowPages)
        {
            var trash = '';
            if(ui.isAdmin)
            {
                trash = "<small><i class=\"fa fa-trash float-right margin-right-5px margin-top-7px delete-yellow-pages-ad\" data-ad=\""+ ui.id +"\"></i></small>";
            }

            var contact = "<div class=\"center yellow-pages-background-color border-top-grey\">"+
                                "<span class=\"yellow-pages-hightlight call-number\" data-number=\""+ ui.number +"\" data-name=\""+ ui.name +"\" data-app=\"phone-calling\">Call <i class=\"fa fa-phone\"></i></span> | "+
                                "<span class=\"yellow-pages-hightlight new-text-message\" data-number=\""+ ui.number +"\" data-name=\""+ ui.name +"\" data-app=\"message-texts\">Message <i class=\"fa fa-comments\"></i></span>"+
                            "</div>";
            if(ui.isPoster)
            {
                contact = '';
            }

            $('#yellow-pages-ad-list').append("<div class=\"border-bottom-grey\">"+
                                                    "<div class=\"margin-left-5px\"><h4>"+ ui.name + trash +"</h4></div>"+
                                                    "<div class=\"margin-left-20px margin-bottom-5px margin-right-10px\">"+
                                                        ui.message +
                                                    "</div>"+
                                                    contact+
                                                "</div>");
        }

        //Updates message text name to contact name
        if(ui.updateMessageContact)
        {
            $('#message-contact').empty().html(ui.name);
        }

        //Adds boss menu app if player job grade matches highest grade of current job
        if(ui.addBossApp)
        {
            var appCount = 0
            $('.icon').each(function(){
                appCount++;
            })

            $('.custom-icon').each(function(){
                appCount++;
            })
            
            if(appCount % 4 == 0)
            {
                $('#home-screen').append('<img id="boss-menu" class="icon icon-left" src="img/boss-icon.png" data-app="boss-menu" />');
            }
            else
            {
                $('#home-screen').append('<img id="boss-menu" class="icon" src="img/boss-icon.png" data-app="boss-menu" />');
            }
        }
        if(ui.removeBossApp)
        {
            $('#boss-menu').remove();
        }

        //Adds boss menu employee rank
        if(ui.addGradeToBossMenu)
        {
            $('#employee-list').append('<div id="grade-'+ ui.grade +'" class="border-bottom-grey">'+
                                            '<h4 class="margin-left-5px">'+ ui.label +'</h4>'+
                                        '</div>');
        }
        if(ui.addEmployeeToBossMenu)
        {
            var demote = '';
            if(ui.grade != 0)
            {
                demote = '<i class="fa fa-arrow-circle-down float-right margin-right-10px margin-bottom-10px font-size-20 boss-menu-demote" data-identifier="'+ ui.identifier +'" data-grade="'+ ui.grade +'" data-job="'+ ui.job +'"></i>';
            }

            var promote = '<i class="fa fa-arrow-circle-up float-right margin-right-10px margin-bottom-10px font-size-20 boss-menu-promote" data-identifier="'+ ui.identifier +'" data-grade="'+ ui.grade +'" data-job="'+ ui.job +'"></i>';
            var fire = '<i class="fa fa-times-circle float-right margin-right-10px margin-bottom-10px font-size-20 boss-menu-fire" data-identifier="'+ ui.identifier +'" data-job="'+ ui.job +'"></i>';
            if(ui.isBoss)
            {
                promote = '';
                fire = '';
            }

            $('#grade-' + ui.grade).append('<p class="margin-left-20px">'+
                                                ui.firstname + ' ' + ui.lastname +
                                                promote +
                                                demote +
                                                fire +
                                                '<i class="fa fa-wallet float-right margin-right-10px margin-bottom-10px font-size-20 boss-menu-pay" data-identifier="'+ ui.identifier +'"></i>'+
                                            '</p>');
        }

        //Add notification app tab
        if(ui.addAppToLockscreen)
        {
            var icon = setNotificationTabApp(ui.app);
            
            $('#nav-tab').append('<button class="nav-link transparent margin-left-1px margin-right-1px border-none" id="nav-'+ ui.app +'-tab" data-bs-toggle="tab" data-bs-target="#nav-'+ ui.app +'" type="button" role="tab" aria-controls="nav-'+ ui.app +'" aria-selected="false">'+ icon +'</button>')
            $('#nav-tabContent').append('<div class="tab-pane fade overflow-auto scroll-bar notification-content" id="nav-'+ ui.app +'" role="tabpanel" aria-labelledby="nav-'+ ui.app +'-tab"></div>')
        }
        if(ui.addNotificationToApp)
        {
            var icon = setNotificationApp(ui.app)
            $('#nav-'+ ui.app).append('<div class="notification-bubble margin-top-5px margin-left-10px margin-right-10px padding-left-10px padding-right-10px" data-app="'+ ui.app +'" data-id="'+ ui.id +'">'+
                                            icon+ '<span> '+ ui.app.charAt(0).toUpperCase() + ui.app.slice(1) +
                                            '<p>'+ui.text+'</p>'+
                                        '</div>')
        }

        if(ui.addToMultiJob)
        {
            var icon = ''
            if(ui.isActive)
            {
                icon = '<i class="fas fa-external-link-alt float-right margin-right-10px font-size-24 hint multi-job-sign-off" title="Sign Off"></i>';
            }
            else
            {
                icon = '<i class="fas fa-edit float-right margin-right-10px font-size-24 hint multi-job-sign-on" title="Sign on" data-job="'+ ui.job +'" data-grade="'+ ui.grade +'"></i>';
            }

            $('#multi-job-list').append('<div class="padding-left-10px padding-right-10px border-bottom-grey">'+
                                            '<h4>'+ ui.jobLabel +'</h4>'+
                                            '<div class="font-size-20 padding-left-10px">' +
                                                ui.gradeLabel +
                                                icon +
                                            '</div>'+
                                        '</div>')
        }

        if(ui.addToNotes)
        {
            $('#notes-list').append("<div class=\"app-list-item note\" data-id=\""+ ui.id +"\" data-app=\"edit-note\">"+
                                        "<strong>"+ ui.title +"</strong>"+
/*                                         "<i class=\"fas fa-share-alt float-right margin-right-5px margin-top-8px share-note\" data-app=\"notes\" data-title=\""+ ui.title +"\"></i>"+
 */                                    "</div>")
        }
        if(ui.editNote)
        {
            $('#edit-note-title').empty().html(ui.title)
            $('#edit-note-text').val(ui.text);
            $('#edit-note-back-button').data("id", ui.id);
            $('#delete-note').data("id", ui.id);
        }

        if(ui.addToCallHistory)
        {
            var item = '';
            if(ui.wasCaller)
            {
                item += '<div class=\"app-list-item call-history\" data-number="'+ ui.receiver +'" data-app=\"phone-calling\">'
                item += '<i class="fas fa-share margin-right-5px"></i>';

                if(ui.name != undefined)
                {
                    if(ui.wasAnswered)
                    {
                        item += "<strong>"+ ui.name +"</strong>";
                    }
                    else
                    {
                        item += "<strong class=\"color-red\">"+ ui.name +"</strong>";
                    }
                }
                else
                {
                    if(ui.wasAnswered)
                    {
                        item += "<strong>"+ ui.receiver +"</strong>";
                    }
                    else
                    {
                        item += "<strong class=\"color-red\">"+ ui.receiver +"</strong>";
                    }
                }
            }
            else
            {
                item += '<div class=\"app-list-item call-history\" data-number="'+ ui.caller +'" data-app=\"phone-calling\">'
                item += '<i class="fas fa-reply margin-right-5px"></i>';
                if(ui.name != undefined)
                {
                    if(ui.wasAnswered)
                    {
                        item += "<strong>"+ ui.name +"</strong>";
                    }
                    else
                    {
                        item += "<strong class=\"color-red\">"+ ui.name +"</strong>";
                    }
                }
                else
                {
                    if(ui.wasAnswered)
                    {
                        item += "<strong>"+ ui.caller +"</strong>";
                    }
                    else
                    {
                        item += "<strong class=\"color-red\">"+ ui.caller +"</strong>";
                    }
                }
            }

            $('#call-history-list').append(item);
        }
        
        if(ui.addToFavoriteContacts)
        {
            $('#contact-favorite-list').append("<div class=\"app-list-item favorite-contact\" data-number=\"" + ui.number + "\" data-app=\"phone-calling\">"+
                                                    "<strong>"+ ui.name +"</strong><span class=\"float-right margin-right-5px\">"+ ui.number +"</span>"+
                                                "</div>")
        }
    })

    function setNotificationTabApp(app)
    {
        var icon = ''
        switch(app)
        {
            case "twitter":
                icon = '<img class="notification-icon" src="img/twitter-icon.png"/>';
                break;
            case "messages":
                icon = '<img class="notification-icon" src="img/messages-icon.png"/>';
                break;
            case "phone":
                icon = '<img class="notification-icon" icon-left" src="img/phone-icon.png"/>';
                break;
            case "ping":
                icon = '<img class="notification-icon" src="img/ping-icon.png"/>';
                break;
        }

        return icon;
    }

    function setNotificationApp(app)
    {
        var icon = ''
        switch(app)
        {
            case "twitter":
                icon = '<i class="fab fa-twitter"></i>';
                break;
            case "messages":
                icon = '<i class="fa fa-comment"></i>';
                break;
            case "phone":
                icon = '<i class="fa fa-phone"></i>';
                break;
            case "ping":
                icon = '<i class="fas fa-map-marker-alt"></i>';
                break;
        }

        return icon;
    }

    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            resetUI()

            $.post('http://labrp-phone/exit', JSON.stringify({}));
            $.post('http://labrp-phone/end-call', JSON.stringify({}));

            return
        }
    };
    $("#close").click(function () {
        resetUI()

        $.post('http://labrp-phone/exit', JSON.stringify({}));        
        $.post('http://labrp-phone/end-call', JSON.stringify({}));

        return
    })

    function resetUI()
    {
        gettingCalled = false;
        //$('.apps').css('visibility', 'visible').css('display', 'flex').addClass('d-flex');
        //$('.app').css('visibility', 'hidden').css('display', 'none').removeClass('d-flex');
    }

    function numberHasLetters(number) {
        var regExp = /[a-zA-Z]/g;
                    
        if(regExp.test(number)){
            return true;
        } else {
            return false;
        }
    }
})