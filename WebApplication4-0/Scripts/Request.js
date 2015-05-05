


$(document).ready(function () {

    //on any input for the modcode, the data is sent to the c# function. This performs query on server and sends back data.
    //returns relevant modname depending on modcode entered
    $('#modcodeInput').on('input click paste focusout', function () {   //removed propertychange as it was buggy in ie8
        var modcode = $('#modcodeInput').val();
        //var modname = $('#MainContent_modnameInput').val();
        //var dataInput = "{modcode: " + modcode + "}";

        $.ajax({
            type: "POST",
            url: "Request.aspx/ModcodeToModname",
            data: JSON.stringify({ modcode: modcode }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                document.getElementById('modnameInput').value = result.d;   //have to write as result.d for some reason
            }
        });
    });

    //on any input to modname, tries to find relevant modcode and updates modcode input
    //does same thing as function above, but for modname
    $('#modnameInput').on('input paste click focusout', function () {

        var modname = $('#modnameInput').val();

        $.ajax({
            type: "POST",
            url: "Request.aspx/ModnameToModcode",
            data: JSON.stringify({ modname: modname }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
            }
        });
    });




    $('#preferencesButton').click(function () {
        document.getElementById("modDetails").style.display = "none";
        document.getElementById("preferenceTable").style.display = "";
        document.getElementById("lecturerRowTable").style.display = "none";
        $('#title').html("FACILITY OPTIONS (ROOM 1)");
    });
    $('#preferencesDoneButton, #preferencesDoneButton2, #preferencesDoneButton3').click(function () {
        document.getElementById("modDetails").style.display = "";
        document.getElementById("preferenceTable").style.display = "none";
        document.getElementById("preferenceTable2").style.display = "none";
        document.getElementById("preferenceTable3").style.display = "none";
        $('#title').html("MODULE DETAILS");
        document.getElementById("lecturerRowTable").style.display = "";
    });

    /*
        autocomplete function for lecturer input
        minimum number of characters = 0, before search begins
        can search for either lecturer name, or lecturer id
    */


    $("#lecturerInput").autocomplete({ minLength: 0 }, {

        source: function (request, response) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Request.aspx/GetLecturers",
                data: "{'term':'" + $("#lecturerInput").val() + "'}",
                dataType: "json",
                success: function (data) {
                    response(data.d);
                },
                error: function (result) {
                    alert("Error");
                }
            });
        }
    });


    //autocomplete function for module name
    //minimum number of characters = 3, before search begins
    $("#modnameInput").autocomplete({ minLength: 3 }, {

        source: function (request, response) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Request.aspx/GetModnames",
                data: "{'term':'" + $("#modnameInput").val() + "'}",
                dataType: "json",
                success: function (data) {
                    response(data.d);
                },
                error: function (result) {
                    alert("Error");
                }
            });
        }
    });


    //autocomplete function for module code
    //minimum number of characters = 2, before search begins
    $("#modcodeInput").autocomplete({ minLength: 2 }, {

        source: function (request, response) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Request.aspx/GetModcodes",
                data: "{'term':'" + $("#modcodeInput").val() + "'}",
                dataType: "json",
                success: function (data) {
                    response(data.d);
                },
                error: function (result) {
                    alert("Error");
                }
            });
        }
    });

    /*
    Allows user to specify facilities of up to 3 rooms, depending on the number of rooms they require.
    Does this by hiding/unhiding the buttons that allows the user to go to the specific room facility page 
   */
    $(function () {
        //initially only 1 room chosen
        $('#gotoRoom2').hide();
        $('#gotoRoom3').hide();
        $('#numRooms').change(function () {
            var numRooms = document.getElementById('numRooms').value;
            if (numRooms == 1) {
                $('#gotoRoom2').hide();
                $('#gotoRoom3').hide();
            }
            //when 2 rooms chosen, access to room 2 must be given and access to room 3 must be disallowed. 
            if (numRooms == 2) {
                $('#gotoRoom2').show();
                $('#gotoRoom3').hide();

            }
            //when 3 rooms chosen, access to room 3 AND room 2 must be given. All rooms are accessible
            if (numRooms == 3) {
                $('#gotoRoom2').show();
                $('#gotoRoom3').show();
            }
        });
    });

    /*
    Function to apply effects of blurring the background, whilst showing popup, then when popup closes, the background returns to normal 
    For weeks popup.
    Includes functions for the weeks popup.
    */
    $(function () {
        $("#defaultWeeksNo").click(function () { //onclick, fades in to display
            $('#popupWeeks').fadeIn(1000);
            $('#requestContainer').removeClass('blur-out');
            $('#requestContainer').addClass('blur-in');

            //only blurs the text in the footer
            $('footer .float-left').removeClass('blur-out');
            $('footer .float-left').addClass('blur-in');

            //blurs header content, i.e. navigation
            $('header').removeClass('blur-out');
            $('header').addClass('blur-in');
        });

        //Close popup weeks
        $("#closePopup").click(function () { //onclick, fades out
            $('#popupWeeks').fadeOut(1000);
            //$('#requestContainer').removeClass('blur-in');
            $('#requestContainer').addClass('blur-out');
            $('#requestContainer').removeClass('blur-in');

            //unblurs the text in the footer
            $('footer .float-left').addClass('blur-out');
            $('footer .float-left').removeClass('blur-in');

            //unblurs header content
            $('header').addClass('blur-out');
            $('header').removeClass('blur-in');
        });

        //sets all the weeks to none checked
        $('#resetWeeks').click(function () {
            // $('#week9').is(':checked')
            for (i = 0; i < 16; i++) {
                $('#week' + i).prop('checked', false);
            }
        });

        //sets all the weeks to all checked
        $('#selectAllWeeks').click(function () {
            // $('#week9').is(':checked')
            for (i = 0; i < 16; i++) {
                $('#week' + i).prop('checked', true);
            }
        });
    });

    //closes and opens the facility popup
    $(function () {
        $('#checkbox_yesPreferences').click(function () {
            $('#popupFacilities').fadeIn(1000);
            $('#requestContainer').removeClass('blur-out');
            $('#requestContainer').addClass('blur-in');

            //only blurs the text in the footer
            $('footer .float-left').removeClass('blur-out');
            $('footer .float-left').addClass('blur-in');

            //blurs header content, i.e. navigation
            $('header').removeClass('blur-out');
            $('header').addClass('blur-in');
        });

        $('#checkbox_yesPreferences2').click(function () {
            $('#popupFacilities2').fadeIn(1000);
            $('#requestContainer').removeClass('blur-out');
            $('#requestContainer').addClass('blur-in');

            //only blurs the text in the footer
            $('footer .float-left').removeClass('blur-out');
            $('footer .float-left').addClass('blur-in');

            //blurs header content, i.e. navigation
            $('header').removeClass('blur-out');
            $('header').addClass('blur-in');
        });

        $('#checkbox_yesPreferences3').click(function () {
            $('#popupFacilities3').fadeIn(1000);
            $('#requestContainer').removeClass('blur-out');
            $('#requestContainer').addClass('blur-in');

            //only blurs the text in the footer
            $('footer .float-left').removeClass('blur-out');
            $('footer .float-left').addClass('blur-in');

            //blurs header content, i.e. navigation
            $('header').removeClass('blur-out');
            $('header').addClass('blur-in');
        });

        //Close popup facilities
        $("#closePopupFacilities").click(function () { //onclick, fades out
            $('#popupFacilities').fadeOut(1000);
            //$('#requestContainer').removeClass('blur-in');
            $('#requestContainer').addClass('blur-out');
            $('#requestContainer').removeClass('blur-in');

            //unblurs the text in the footer
            $('footer .float-left').addClass('blur-out');
            $('footer .float-left').removeClass('blur-in');

            //unblurs header content
            $('header').addClass('blur-out');
            $('header').removeClass('blur-in');
        });

        //Close popup facilities 2
        $("#closePopupFacilities2").click(function () { //onclick, fades out
            $('#popupFacilities2').fadeOut(1000);
            //$('#requestContainer').removeClass('blur-in');
            $('#requestContainer').addClass('blur-out');
            $('#requestContainer').removeClass('blur-in');

            //unblurs the text in the footer
            $('footer .float-left').addClass('blur-out');
            $('footer .float-left').removeClass('blur-in');

            //unblurs header content
            $('header').addClass('blur-out');
            $('header').removeClass('blur-in');
        });

        //Close popup facilities 3
        $("#closePopupFacilities3").click(function () { //onclick, fades out
            $('#popupFacilities3').fadeOut(1000);
            //$('#requestContainer').removeClass('blur-in');
            $('#requestContainer').addClass('blur-out');
            $('#requestContainer').removeClass('blur-in');

            //unblurs the text in the footer
            $('footer .float-left').addClass('blur-out');
            $('footer .float-left').removeClass('blur-in');

            //unblurs header content
            $('header').addClass('blur-out');
            $('header').removeClass('blur-in');
        });
    });



    //allows user to go to preferences for 2nd room. So can select a different room on inputted capacity etc.
    $('#gotoRoom2').click(function () {
        $('#preferenceTable').hide();
        $('#preferenceTable2').show();
        $('#title').html("FACILITY OPTIONS (ROOM 2)");
    });

    $('#gotoPrevRoom1').click(function () {
        $('#preferenceTable2').hide();
        $('#preferenceTable').show();
        $('#title').html("FACILITY OPTIONS (ROOM 1)");
    });

    $('#gotoRoom3').click(function () {
        $('#preferenceTable2').hide();
        $('#preferenceTable3').show();
        $('#title').html("FACILITY OPTIONS (ROOM 3)");
    });

    $('#gotoPrevRoom2').click(function () {
        $('#preferenceTable3').hide();
        $('#preferenceTable2').show();
        $('#title').html("FACILITY OPTIONS (ROOM 2)");
    });
    /*
    On park checkbox selection, updates the buildings that the user can select from.
    If the user selects central park, only buildings from central park shown.
    User can select multiple parks through checkboxes.
    */
    $('.parkClass').change(function () {
        //if checked, then is set to true, otherwise false
        var central = document.getElementById('checkbox_centralPark').checked;
        var east = document.getElementById('checkbox_eastPark').checked;
        var west = document.getElementById('checkbox_westPark').checked;

        $.ajax({
            type: "POST",
            url: "Request.aspx/ShowBuildingSelect",
            data: JSON.stringify({ central: central, east: east, west: west }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                //document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                //alert(result.d);
                $('#select_building').html(result.d);
            }
        });
    });

    //same thing as above, but for room 2
    $('.parkClass2').change(function () {
        //if checked, then is set to true, otherwise false
        var central = document.getElementById('checkbox_centralPark2').checked;
        var east = document.getElementById('checkbox_eastPark2').checked;
        var west = document.getElementById('checkbox_westPark2').checked;

        $.ajax({
            type: "POST",
            url: "Request.aspx/ShowBuildingSelect",
            data: JSON.stringify({ central: central, east: east, west: west }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                //document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                //alert(result.d);
                $('#select_building2').html(result.d);
            }
        });
    });


    //same thing as above, but for room 3
    $('.parkClass3').change(function () {
        //if checked, then is set to true, otherwise false
        var central = document.getElementById('checkbox_centralPark3').checked;
        var east = document.getElementById('checkbox_eastPark3').checked;
        var west = document.getElementById('checkbox_westPark3').checked;

        $.ajax({
            type: "POST",
            url: "Request.aspx/ShowBuildingSelect",
            data: JSON.stringify({ central: central, east: east, west: west }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                //document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                //alert(result.d);
                $('#select_building3').html(result.d);
            }
        });
    });
    /*
    will show all buildings available to select onload, seeing as west, central, east initially checked onload
    Does this for room 2 and room 3 also
    */
    $(function () {
        var central = document.getElementById('checkbox_centralPark').checked;
        var east = document.getElementById('checkbox_eastPark').checked;
        var west = document.getElementById('checkbox_westPark').checked;
        $.ajax({
            type: "POST",
            url: "Request.aspx/ShowBuildingSelect",
            data: JSON.stringify({ central: central, east: east, west: west }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                //document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                //alert(result.d);
                $('#select_building').html(result.d);
                $('#select_building2').html(result.d);
                $('#select_building3').html(result.d);
            }
        });
    });

    /* 
    This will update the rooms available to select based on the building that the user selects.
    If user selects James France, then the rooms for james france will be shown.
    TO DO - This will also take into consideration room type, capacity and room facilities. 
    */
    //Updates when building selected changed, also when room type is changed
    $('#select_building, .roomTypeClass, #capacityInput, .facilityCheckboxes, .requestFacilitiesClass, .parkClass').change(function () {
        //variables to send to the C# class
        var building = document.getElementById('select_building').value; //selected building code
        var lecture = document.getElementById('checkbox_Lecture').checked; // set to true if user wants a lecture room type
        var seminar = document.getElementById('checkbox_Seminar').checked; //set to true if user wants a seminar
        var lab = document.getElementById('checkbox_Lab').checked; //set to true if user wants a lab
        var capacity = document.getElementById('capacityInput').value;

        if (document.getElementById('checkbox_noPreferences').checked) {// if user selects 'no' facilities required, then all set to default false 
            var comp = false; //computer
            var ddp = false;    //Dual Data projection
            var dp = false;    //Data Projection
            var il = false;    //Induction Loop
            var mp = false;    //Media Player
            var pa = false;    //PA
            var plasma = false;  //Plasma
            var rev = false;    //ReView
            var mic = false;     //Radio Microphone
            var vis = false;    //Visualiser
            var wc = false;  //Wheelchair Access
            var wb = false;      //Whiteboard
        } else {    //if user selects 'yes' they do want to specify facilities
            //room preference selections, such as whiteboard
            var comp = document.getElementById('checkbox_COMP').checked;    //computer 
            var ddp = document.getElementById('checkbox_DDP').checked;     //Dual Data projection
            var dp = document.getElementById('checkbox_DP').checked;      //Data Projection
            var il = document.getElementById('checkbox_IL').checked;      //Induction Loop
            var mp = document.getElementById('checkbox_MP').checked;      //Media Player
            var pa = document.getElementById('checkbox_PA').checked;      //PA
            var plasma = document.getElementById('checkbox_PLASMA').checked;  //Plasma
            var rev = document.getElementById('checkbox_REV').checked;     //ReView
            var mic = document.getElementById('checkbox_MIC').checked;      //Radio Microphone
            var vis = document.getElementById('checkbox_VIS').checked;     //Visualiser
            var wc = document.getElementById('checkbox_Wchair').checked;  //Wheelchair Access
            var wb = document.getElementById('checkbox_WB').checked;      //Whiteboard
        }

        //if no building selected, then 0 is sent.
        $.ajax({
            type: "POST",
            url: "Request.aspx/ShowRooms",
            data: JSON.stringify({
                building: building, lecture: lecture, seminar: seminar, lab: lab, capacity: capacity,
                comp: comp, ddp: ddp, dp: dp, il: il, mp: mp, pa: pa, plasma: plasma, rev: rev, mic: mic,
                vis: vis, wc: wc, wb: wb
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                //document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                //alert(result.d);
                $('#select_room').html(result.d);
            }
        });
    });

    //same as above, but for room 2
    $('#select_building2, .roomTypeClass2, #capacityInput2, .facilityCheckboxes2, .requestFacilitiesClass2, .parkClass2').change(function () {
        //variables to send to the C# class
        var building = document.getElementById('select_building2').value; //selected building code
        var lecture = document.getElementById('checkbox_Lecture2').checked; // set to true if user wants a lecture room type
        var seminar = document.getElementById('checkbox_Seminar2').checked; //set to true if user wants a seminar
        var lab = document.getElementById('checkbox_Lab2').checked; //set to true if user wants a lab
        var capacity = document.getElementById('capacityInput2').value;

        if (document.getElementById('checkbox_noPreferences2').checked) {// if user selects 'no' facilities required, then all set to default false 
            var comp = false; //computer
            var ddp = false;    //Dual Data projection
            var dp = false;    //Data Projection
            var il = false;    //Induction Loop
            var mp = false;    //Media Player
            var pa = false;    //PA
            var plasma = false;  //Plasma
            var rev = false;    //ReView
            var mic = false;     //Radio Microphone
            var vis = false;    //Visualiser
            var wc = false;  //Wheelchair Access
            var wb = false;      //Whiteboard
        } else {    //if user selects 'yes' they do want to specify facilities
            //room preference selections, such as whiteboard
            var comp = document.getElementById('checkbox_COMP2').checked;    //computer 
            var ddp = document.getElementById('checkbox_DDP2').checked;     //Dual Data projection
            var dp = document.getElementById('checkbox_DP2').checked;      //Data Projection
            var il = document.getElementById('checkbox_IL2').checked;      //Induction Loop
            var mp = document.getElementById('checkbox_MP2').checked;      //Media Player
            var pa = document.getElementById('checkbox_PA2').checked;      //PA
            var plasma = document.getElementById('checkbox_PLASMA2').checked;  //Plasma
            var rev = document.getElementById('checkbox_REV2').checked;     //ReView
            var mic = document.getElementById('checkbox_MIC2').checked;      //Radio Microphone
            var vis = document.getElementById('checkbox_VIS2').checked;     //Visualiser
            var wc = document.getElementById('checkbox_Wchair2').checked;  //Wheelchair Access
            var wb = document.getElementById('checkbox_WB2').checked;      //Whiteboard
        }

        //if no building selected, then 0 is sent.
        $.ajax({
            type: "POST",
            url: "Request.aspx/ShowRooms",
            data: JSON.stringify({
                building: building, lecture: lecture, seminar: seminar, lab: lab, capacity: capacity,
                comp: comp, ddp: ddp, dp: dp, il: il, mp: mp, pa: pa, plasma: plasma, rev: rev, mic: mic,
                vis: vis, wc: wc, wb: wb
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                //document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                //alert(result.d);
                $('#select_room2').html(result.d);
            }
        });
    });

    //same as above 2 functions, but for room 3
    $('#select_building3, .roomTypeClass3, #capacityInput3, .facilityCheckboxes3, .requestFacilitiesClass3, .parkClass3').change(function () {
        //variables to send to the C# class
        var building = document.getElementById('select_building3').value; //selected building code
        var lecture = document.getElementById('checkbox_Lecture3').checked; // set to true if user wants a lecture room type
        var seminar = document.getElementById('checkbox_Seminar3').checked; //set to true if user wants a seminar
        var lab = document.getElementById('checkbox_Lab3').checked; //set to true if user wants a lab
        var capacity = document.getElementById('capacityInput3').value;

        if (document.getElementById('checkbox_noPreferences3').checked) {// if user selects 'no' facilities required, then all set to default false 
            var comp = false; //computer
            var ddp = false;    //Dual Data projection
            var dp = false;    //Data Projection
            var il = false;    //Induction Loop
            var mp = false;    //Media Player
            var pa = false;    //PA
            var plasma = false;  //Plasma
            var rev = false;    //ReView
            var mic = false;     //Radio Microphone
            var vis = false;    //Visualiser
            var wc = false;  //Wheelchair Access
            var wb = false;      //Whiteboard
        } else {    //if user selects 'yes' they do want to specify facilities
            //room preference selections, such as whiteboard
            var comp = document.getElementById('checkbox_COMP3').checked;    //computer 
            var ddp = document.getElementById('checkbox_DDP3').checked;     //Dual Data projection
            var dp = document.getElementById('checkbox_DP3').checked;      //Data Projection
            var il = document.getElementById('checkbox_IL3').checked;      //Induction Loop
            var mp = document.getElementById('checkbox_MP3').checked;      //Media Player
            var pa = document.getElementById('checkbox_PA3').checked;      //PA
            var plasma = document.getElementById('checkbox_PLASMA3').checked;  //Plasma
            var rev = document.getElementById('checkbox_REV3').checked;     //ReView
            var mic = document.getElementById('checkbox_MIC3').checked;      //Radio Microphone
            var vis = document.getElementById('checkbox_VIS3').checked;     //Visualiser
            var wc = document.getElementById('checkbox_Wchair3').checked;  //Wheelchair Access
            var wb = document.getElementById('checkbox_WB3').checked;      //Whiteboard
        }

        //if no building selected, then 0 is sent.
        $.ajax({
            type: "POST",
            url: "Request.aspx/ShowRooms",
            data: JSON.stringify({
                building: building, lecture: lecture, seminar: seminar, lab: lab, capacity: capacity,
                comp: comp, ddp: ddp, dp: dp, il: il, mp: mp, pa: pa, plasma: plasma, rev: rev, mic: mic,
                vis: vis, wc: wc, wb: wb
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                //document.getElementById('modcodeInput').value = result.d;   //have to write as result.d for some reason
                //alert(result.d);
                $('#select_room3').html(result.d);
            }
        });
    });


    $('#changeTime').click(function () {
        if (document.getElementById('select_startTime').options[0].text != '1') { //if not already set to period, then set to period
            //change label to say period
            $('#MainContent_startPeriodLabel').show();
            $('#MainContent_startTimeLabel').hide();
            $('#MainContent_endPeriodLabel').show();
            $('#MainContent_endTimeLabel').hide();

            for (i = 0; i < 9; i++) {
                document.getElementById('select_startTime').options[i].text = i + 1;
                document.getElementById('select_endTime').options[i].text = i + 2;
            }

        } else {    //if it has been set to period, now changes back to normal time

            //change label to say time
            $('#MainContent_startPeriodLabel').hide();
            $('#MainContent_startTimeLabel').show();
            $('#MainContent_endPeriodLabel').hide();
            $('#MainContent_endTimeLabel').show();
            for (i = 0; i < 9; i++) { //sets back to normal time form rather than periods i.e. 09:00:00 instead of 1
                //document.getElementById('select_startTime').options[i].text = (document.getElementById('select_startTime').options[i].value).substring(0, 5);
                //document.getElementById('select_endTime').options[i].text = (document.getElementById('select_endTime').options[i].value).substring(0, 5);
                document.getElementById('select_startTime').options[i].text = i + 9 + ":00";
                document.getElementById('select_endTime').options[i].text = i + 10 + ":00";
            }

        }
    });



    /*
         VALIDATION FOR TIME SELECTION
         if the user selects a start time which is later then the end time, will not be allowed, user will be notified.
    */
    $('#select_startTime, #select_endTime').change(function () {
        var startTime = +document.getElementById('select_startTime').value;
        var endTime = +document.getElementById('select_endTime').value;
        if (startTime >= endTime) {
            showValidation();
            //showValidation("The <b>'Start time'</b> cannot finish after <b>'End Time'</b>, it must be before.");   //opens up validation message box
            $('#messageContents').html("The <b>'Start time'</b> must be before the <b>'End Time'</b>.");
            //Sets red to bottom border of the corresponding labels, highlighting user of the location of the error.
            document.getElementById("MainContent_startTimeLabel").style.borderBottom = "3px solid red";
            document.getElementById("MainContent_endTimeLabel").style.borderBottom = "3px solid red";
            document.getElementById("MainContent_startPeriodLabel").style.borderBottom = "3px solid red";
            document.getElementById("MainContent_endPeriodLabel").style.borderBottom = "3px solid red";
        } else { //gets rid of the red border
            document.getElementById("MainContent_startTimeLabel").style.borderBottom = "";
            document.getElementById("MainContent_endTimeLabel").style.borderBottom = "";
            document.getElementById("MainContent_startPeriodLabel").style.borderBottom = "";
            document.getElementById("MainContent_endPeriodLabel").style.borderBottom = "";
        }
    });

    function showValidation() {
        $('#validationContainer').show();
        formInputEnabled('false');  //disable changing of input until this is closed.
        $('#requestContainer').removeClass('blur-out');
        $('#requestContainer').addClass('blur-in');

        //only blurs the text in the footer
        $('footer .float-left').removeClass('blur-out');
        $('footer .float-left').addClass('blur-in');

        //blurs header content, i.e. navigation
        $('header').removeClass('blur-out');
        $('header').addClass('blur-in');
    }


    $('#closeValidation').click(function () {
        $('#validationContainer').hide();
        formInputEnabled('true');
        $('#requestContainer').addClass('blur-out');
        $('#requestContainer').removeClass('blur-in');

        //unblurs the text in the footer
        $('footer .float-left').addClass('blur-out');
        $('footer .float-left').removeClass('blur-in');

        //unblurs header content
        $('header').addClass('blur-out');
        $('header').removeClass('blur-in');
    });

    /* brings up confirmation box */
    function showConfirmation() {
        $('#confirmationContainer').show();
        $('#requestContainer').removeClass('blur-out');
        $('#requestContainer').addClass('blur-in');

        //only blurs the text in the footer
        $('footer .float-left').removeClass('blur-out');
        $('footer .float-left').addClass('blur-in');

        //blurs header content, i.e. navigation
        $('header').removeClass('blur-out');
        $('header').addClass('blur-in');
    }

    $('#cancelRequest').click(function () {
        formInputEnabled("true");
        $('#confirmationContainer').hide();

        $('#requestContainer').addClass('blur-out');
        $('#requestContainer').removeClass('blur-in');

        //unblurs the text in the footer
        $('footer .float-left').addClass('blur-out');
        $('footer .float-left').removeClass('blur-in');

        //unblurs header content
        $('header').addClass('blur-out');
        $('header').removeClass('blur-in');
    });

    function closeConfirmation() {
        formInputEnabled("true");
        $('#confirmationContainer').hide();

        $('#requestContainer').addClass('blur-out');
        $('#requestContainer').removeClass('blur-in');

        //unblurs the text in the footer
        $('footer .float-left').addClass('blur-out');
        $('footer .float-left').removeClass('blur-in');

        //unblurs header content
        $('header').addClass('blur-out');
        $('header').removeClass('blur-in');
    }

    /*
      
      performs validation before submitting the request, to ensure required fields entered are valid and non empty.
    */
    $('#submitButton').click(function () {
        var lecturerName = $('#lecturer1').html();
        //var lecturerName = lecturer;
        var lecturerName2 = $('#lecturer2').html();
        var lecturerName3 = $('#lecturer3').html();

        var modcode = $('#modcodeInput').val().toUpperCase();
        var modname = $('#modnameInput').val();

        var day = $('#daySelect').val();
        var dayString = document.getElementById('daySelect').options[document.getElementById('daySelect').value - 1].text; //i.e. monday instead of 1

        var startTimeString = document.getElementById('select_startTime').options[document.getElementById('select_startTime').value - 1].text;//i.e. 10:00 instead of 2
        var endTimeString = document.getElementById('select_endTime').options[document.getElementById('select_endTime').value - 2].text;//i.e. 10:00 instead of 2
        var startTime = +document.getElementById('select_startTime').value; //1-9
        var endTime = +document.getElementById('select_endTime').value; //2-10

        var numRooms = $('#numRooms').val();
        var roomCap1 = $('#capacityInput').val();
        var roomCap2 = $('#capacityInput2').val();
        var roomCap3 = $('#capacityInput3').val();

        var priorityString = "No";
        if (document.getElementById('priorityYes').checked) {
            priorityString = "Yes";
        }
        //var weeks array is an array containing the weeks selected. Declared later on.
        var capacity = +roomCap1;

        if (numRooms == 2) {
            capacity = +roomCap1 + +roomCap2;
        }
        if (numRooms == 3) {
            capacity = +roomCap1 + +roomCap2 + +roomCap3;   //unary plus operator, converts string to number                }
        }

        var flag = true; // if on clicking submit, no errors occur, can complete submission. Else will notify user of the errors to fix.

        $('#messageContents').html("<ul id='errorList'></ul>");
        $('#messageContents').append("Cannot submit until you correct the above error(s)");

        /*if module code is empty*/

        if (modcode == "") {
            flag = false;
            showValidation();
            $('#errorList').append("<li><b>'Module Code'</b> is empty. Please enter a value</li>");
            document.getElementById("MainContent_modcodeLabel").style.borderBottom = "3px solid red";
        } else { //error corrected
            document.getElementById("MainContent_modcodeLabel").style.borderBottom = "";
        }

        /*if module name is empty*/

        if (modname == "") {
            flag = false;
            showValidation();
            $('#errorList').append("<li><b>'Module Name'</b> is empty. Please enter a value</li>");
            document.getElementById("MainContent_modnameLabel").style.borderBottom = "3px solid red";
        } else { //error corrected
            document.getElementById("MainContent_modnameLabel").style.borderBottom = "";
        }

        /*if module name is empty */

        if (startTime > endTime) {
            flag = false;
            showValidation();
            $('#errorList').append("<li><b>'Start Time'</b> must be before <b>'End Time'</b>.  Please change desired times.</li>");
            document.getElementById("MainContent_startTimeLabel").style.borderBottom = "3px solid red";
            document.getElementById("MainContent_endTimeLabel").style.borderBottom = "3px solid red";
            document.getElementById("MainContent_startPeriodLabel").style.borderBottom = "3px solid red";
            document.getElementById("MainContent_endPeriodLabel").style.borderBottom = "3px solid red";
        } else { //gets rid of the red border
            document.getElementById("MainContent_startTimeLabel").style.borderBottom = "";
            document.getElementById("MainContent_endTimeLabel").style.borderBottom = "";
            document.getElementById("MainContent_startPeriodLabel").style.borderBottom = "";
            document.getElementById("MainContent_endPeriodLabel").style.borderBottom = "";
        }

        /* if the lecturers names do not match the db */
        //if no lecturers added
        if (numLecturer == 0) {
            flag = false;
            showValidation();
            $('#errorList').append("<li>Please assign a <b>'Lecturer'</b> to the module.</li>");
            document.getElementById("MainContent_lecturerLabel").style.borderBottom = "3px solid red";
        } else {
            document.getElementById("MainContent_lecturerLabel").style.borderBottom = "";
        }

        //Performs validation if 1 lecturer assigned
        if (numLecturer == 1) {
            if (validateLecturer(1) == false) {
                flag = false;
                showValidation();
                $('#errorList').append("<li><b>'Lecturer Name'</b> is incorrect. Please try selecting from the autosuggested list.</li>");
                document.getElementById("MainContent_lecturerLabel").style.borderBottom = "3px solid red";
            } else {
                document.getElementById("MainContent_lecturerLabel").style.borderBottom = "";
            }
        }
        //Performs validation if 2 lecturers assigned
        if (numLecturer == 2) {
            if (validateLecturer(1) == false) {
                flag = false;
                showValidation();
                $('#errorList').append("<li><b>'Lecturer Name'</b> for Lecturer #1 is incorrect. Please try selecting from the autosuggested list.</li>");
                document.getElementById("MainContent_lecturerLabel").style.borderBottom = "3px solid red";
            }

            if (validateLecturer(2) == false) {
                flag = false;
                showValidation();
                $('#errorList').append("<li><b>'Lecturer Name'</b> for Lecturer #2 is incorrect. Please try selecting from the autosuggested list.</li>");
                document.getElementById("MainContent_lecturerLabel").style.borderBottom = "3px solid red";
            }

            if (lecturerName == lecturerName2) {
                flag = false;
                showValidation();
                $('#errorList').append("<li>You cannot assign the Lecturer (" + lecturerName + ")to this module <b>twice</b>. Please correct the error.</li>");
                document.getElementById("MainContent_lecturerLabel").style.borderBottom = "3px solid red";
            }

            if (flag != false) {
                document.getElementById("MainContent_lecturerLabel").style.borderBottom = "";
            }
        }
        //Performs validation if 3 lecturers assigned
        if (numLecturer == 3) {
            if (validateLecturer(1) == false) {
                flag = false;
                showValidation();
                $('#errorList').append("<li><b>'Lecturer Name'</b> for Lecturer #1 is incorrect. Please try selecting from the autosuggested list.</li>");
                document.getElementById("MainContent_lecturerLabel").style.borderBottom = "3px solid red";
            }

            if (validateLecturer(2) == false) {
                flag = false;
                showValidation();
                $('#errorList').append("<li><b>'Lecturer Name'</b> for Lecturer #2 is incorrect. Please try selecting from the autosuggested list.</li>");
                document.getElementById("MainContent_lecturerLabel").style.borderBottom = "3px solid red";
            }

            if (validateLecturer(3) == false) {
                flag = false;
                showValidation();
                $('#errorList').append("<li><b>'Lecturer Name'</b> for Lecturer #3 is incorrect. Please try selecting from the autosuggested list.</li>");
                document.getElementById("MainContent_lecturerLabel").style.borderBottom = "3px solid red";
            }

            if (lecturerName == lecturerName2 && lecturerName != lecturerName3) {
                flag = false;
                showValidation();
                $('#errorList').append("<li>You cannot assign the Lecturer (" + lecturerName + ") to this module <b>twice</b>. Please correct the error.</li>");
                document.getElementById("MainContent_lecturerLabel").style.borderBottom = "3px solid red";
            }
            if (lecturerName == lecturerName3 && lecturerName != lecturerName2) {
                flag = false;
                showValidation();
                $('#errorList').append("<li>You cannot assign the Lecturer (" + lecturerName + ") to this module <b>twice</b>. Please correct the error.</li>");
                document.getElementById("MainContent_lecturerLabel").style.borderBottom = "3px solid red";
            }
            if (lecturerName3 == lecturerName2 && lecturerName3 != lecturerName) {
                flag = false;
                showValidation();
                $('#errorList').append("<li>You cannot assign the Lecturer (" + lecturerName2 + ") to this module <b>twice</b>. Please correct the error.</li>");
                document.getElementById("MainContent_lecturerLabel").style.borderBottom = "3px solid red";
            }
            if (lecturerName == lecturerName2 && lecturerName == lecturerName3) {
                flag = false;
                showValidation();
                $('#errorList').append("<li>You cannot assign the Lecturer (" + lecturerName2 + ") to this module <b>three</b> times. Please correct the error.</li>");
                document.getElementById("MainContent_lecturerLabel").style.borderBottom = "3px solid red";
            }

            if (flag != false) {
                document.getElementById("MainContent_lecturerLabel").style.borderBottom = "";
            }


        }



        /*if the capacity input is empty*/
        if (numRooms == 1) {
            if (roomCap1 == "") {
                flag = false;
                showValidation();
                $('#errorList').append("<li>Please enter a <b>'Capacity'</b> for Room 1. Can be found in <b>'Preferences'</b> for Room 1 </li>");
                document.getElementById("MainContent_capacityLabel").style.borderBottom = "3px solid red";
            } else {  //gets rid of the red border
                document.getElementById("MainContent_capacityLabel").style.borderBottom = "";
            }
        }

        if (numRooms == 2) {
            if (roomCap1 == "") {
                flag = false;
                showValidation();
                $('#errorList').append("<li>Please enter a <b>'Capacity'</b> for Room 1. Can be found in <b>'Preferences'</b> for Room 1 </li>");
                document.getElementById("MainContent_capacityLabel").style.borderBottom = "3px solid red";
            } else {  //gets rid of the red border
                document.getElementById("MainContent_capacityLabel").style.borderBottom = "";
            }
            if (roomCap2 == "") {
                flag = false;
                showValidation();
                $('#errorList').append("<li>Please enter a <b>'Capacity'</b> for Room 2. Can be found in <b>'Preferences'</b> for Room 2 </li>");
                document.getElementById("MainContent_capacity2Label").style.borderBottom = "3px solid red";
            } else {  //gets rid of the red border
                document.getElementById("MainContent_capacity2Label").style.borderBottom = "";
            }
        }

        if (numRooms == 3) {
            if (roomCap1 == "") {
                flag = false;
                showValidation();
                $('#errorList').append("<li>Please enter a <b>'Capacity'</b> for Room 1. Can be found in <b>'Preferences'</b> for Room 1 </li>");
                document.getElementById("MainContent_capacityLabel").style.borderBottom = "3px solid red";
            } else {  //gets rid of the red border
                document.getElementById("MainContent_capacityLabel").style.borderBottom = "";
            }
            if (roomCap2 == "") {
                flag = false;
                showValidation();
                $('#errorList').append("<li>Please enter a <b>'Capacity'</b> for Room 2. Can be found in <b>'Preferences'</b> for Room 2 </li>");
                document.getElementById("MainContent_capacity2Label").style.borderBottom = "3px solid red";
            } else {  //gets rid of the red border
                document.getElementById("MainContent_capacity2Label").style.borderBottom = "";
            }
            if (roomCap3 == "") {
                flag = false;
                showValidation();
                $('#errorList').append("<li>Please enter a <b>'Capacity'</b> for Room 3. Can be found in <b>'Preferences'</b> for Room 3 </li>");
                document.getElementById("MainContent_capacity3Label").style.borderBottom = "3px solid red";
            } else {  //gets rid of the red border
                document.getElementById("MainContent_capacity3Label").style.borderBottom = "";
            }
        }// numRooms 3 closing tag

        var defaultWeeks = document.getElementById('defaultWeeksYes').checked; //if false, then user has selected to choose own weeks


        //var weeks = []; //creates empty array

        /*
            Check if any weeks have been selected when user selects to choose his/her own weeks.
        */

        var weeks = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
        var weekChecked = 12; //12 weeks checked automatically

        if (document.getElementById('defaultWeeksNo').checked == true) {    //if user has selected to choose own weeks
            //check to see if any weeks have been selected.
            weeks = []; //sets the weeks array to empty, so can add the specific weeks user chooses.
            var weekChecked = 0;
            for (i = 1; i < 16; i++) {
                if (document.getElementById('week' + i).checked == true) {
                    weekChecked = weekChecked + 1; //if at least 1 week has been checked, then weekChecked set to true
                    weeks.push(i); //corresponding week number will be added to the array if it has been checked
                    /*
                      If at least 1 week has been checked, then checked weeks set to true.
                      Otherwise, no weeks have been selected. User must be notified.
                  */
                }
            }
        }

        //if user selects to choose own weeks, must select at least 1 week.
        if (weekChecked == 0) {
            flag = false;
            showValidation();
            $('#errorList').append("<li>No weeks have been selected. Please select at least 1 week to continue or set <b>'Default Weeks'</b> to <b>'Yes'</b></li>");
            document.getElementById("MainContent_defaultWeeksLabel").style.borderBottom = "3px solid red";
        } else {  //gets rid of the red border
            document.getElementById("MainContent_defaultWeeksLabel").style.borderBottom = "";
        }


        /*
            If the flag is still true, that means all errors have been handled, can now submit the request to the DB.
        */

        var weeksString = "";
        //iterates through the weeks array, to find out which weeks have been selected
        for (i = 0; i < weeks.length; i++) {
            weeksString += weeks[i] + ", "  //puts contents of the array into the form 1, 2, 3 etc.
        }
        weeksString = weeksString.substring(0, weeksString.length - 2); //gets rid of the ',' at the end.
        if (flag == true) {
            formInputEnabled("false");  //cannot change data once in submission mode
            showConfirmation(); //brings up confirmation pop up
            $('#confirmationContents').html(""); //clears previous added content
            if (numLecturer == 1) {
                $('#confirmationContents').append("<strong>Lecturer:</strong> " + lecturerName + "<br />");
            }
            if (numLecturer == 2) {
                $('#confirmationContents').append("<strong>Lecturers:</strong> " + lecturerName + ", " + lecturerName2 + "<br />");
            }
            if (numLecturer == 3) {
                $('#confirmationContents').append("<strong>Lecturers:</strong> " + lecturerName + ", " + lecturerName2 + ", " + lecturerName3 + "<br />");
            }
            $('#confirmationContents').append("<strong>Module:</strong> " + modname + " (" + modcode + ")" + "<br />");
            //$('#confirmationContents').append("<strong>Module Code:</strong> " + modcode + "<br />");
            $('#confirmationContents').append("<strong>Day:</strong> " + dayString + "<br />");
            $('#confirmationContents').append("<strong>Start Time:</strong> " + startTimeString + " (Period " + startTime + ")" + "<br />");
            $('#confirmationContents').append("<strong>End Time:</strong> " + endTimeString + " (Period " + endTime + ")" + "<br />");
            $('#confirmationContents').append("<strong>Weeks:</strong> " + weeksString + "<br />");
            $('#confirmationContents').append("<strong>Priority:</strong> " + priorityString + "<br />");

            if (numRooms == 1) { //if user has requested just 1 room
                if (document.getElementById('select_room').value != 0) {    //if a room has been chosen
                    $('#confirmationContents').append("<strong>Room:</strong> " + document.getElementById('select_room').value + "<br />");
                } else {
                    $('#confirmationContents').append("<strong>Room:</strong> n/a <br />");
                }
                $('#confirmationContents').append("<strong>Total number of students:</strong> " + capacity + "<br />");
            }
            if (numRooms == 2) {    //if user has requested 2 rooms
                if (document.getElementById('select_room').value != 0) {    //if a room has been chosen
                    $('#confirmationContents').append("<strong>Room 1:</strong> " + document.getElementById('select_room').value + "<br />");
                } else {
                    $('#confirmationContents').append("<strong>Room 1:</strong> n/a <br />");
                }
                if (document.getElementById('select_room2').value != 0) {    //if a room2 has been chosen
                    $('#confirmationContents').append("<strong>Room 2:</strong> " + document.getElementById('select_room2').value + "<br />");
                } else {
                    $('#confirmationContents').append("<strong>Room 2:</strong> n/a <br />");
                }
                $('#confirmationContents').append("<strong>Total number of students:</strong> " + capacity + "<br />");
            }
            if (numRooms == 3) {    //if user has requested 2 rooms
                if (document.getElementById('select_room').value != 0) {    //if a room has been chosen
                    $('#confirmationContents').append("<strong>Room 1:</strong> " + document.getElementById('select_room').value + "<br />");
                } else {
                    $('#confirmationContents').append("<strong>Room 1:</strong> n/a <br />");
                }
                if (document.getElementById('select_room2').value != 0) {    //if a room2 has been chosen
                    $('#confirmationContents').append("<strong>Room 2:</strong> " + document.getElementById('select_room2').value + "<br />");
                } else {
                    $('#confirmationContents').append("<strong>Room 2:</strong> n/a <br />");
                }
                if (document.getElementById('select_room3').value != 0) {    //if a room3 has been chosen
                    $('#confirmationContents').append("<strong>Room 3:</strong> " + document.getElementById('select_room3').value + "<br />");
                } else {
                    $('#confirmationContents').append("<strong>Room 3:</strong> n/a <br />");
                }
                $('#confirmationContents').append("<strong>Total number of students:</strong> " + capacity + "<br />");
            }

        }
    }); //submit action closing tag



    //actually sends the submission variables to c# code via ajax. Where sql query written to db.
    $('#submitRequest').click(function () {
        closeConfirmation();
        //variables to send
        var lecturerName1 = $('#lecturer1').html();
        var lecturerName2 = $('#lecturer2').html();
        var lecturerName3 = $('#lecturer3').html();
        var priority = 0;
        if (document.getElementById('priorityYes').checked) {
            priority = 1;
        }

        //room1 facility options
        if (document.getElementById('checkbox_noPreferences').checked) {// if user selects 'no' facilities required, then all set to default false 
            var comp = false; //computer
            var ddp = false;    //Dual Data projection
            var dp = false;    //Data Projection
            var il = false;    //Induction Loop
            var mp = false;    //Media Player
            var pa = false;    //PA
            var plasma = false;  //Plasma
            var rev = false;    //ReView
            var mic = false;     //Radio Microphone
            var vis = false;    //Visualiser
            var wc = false;  //Wheelchair Access
            var wb = false;      //Whiteboard
        } else {    //if user selects 'yes' they do want to specify facilities
            //room preference selections, such as whiteboard
            var comp = document.getElementById('checkbox_COMP').checked;    //computer 
            var ddp = document.getElementById('checkbox_DDP').checked;     //Dual Data projection
            var dp = document.getElementById('checkbox_DP').checked;      //Data Projection
            var il = document.getElementById('checkbox_IL').checked;      //Induction Loop
            var mp = document.getElementById('checkbox_MP').checked;      //Media Player
            var pa = document.getElementById('checkbox_PA').checked;      //PA
            var plasma = document.getElementById('checkbox_PLASMA').checked;  //Plasma
            var rev = document.getElementById('checkbox_REV').checked;     //ReView
            var mic = document.getElementById('checkbox_MIC').checked;      //Radio Microphone
            var vis = document.getElementById('checkbox_VIS').checked;     //Visualiser
            var wc = document.getElementById('checkbox_Wchair').checked;  //Wheelchair Access
            var wb = document.getElementById('checkbox_WB').checked;      //Whiteboard
        }

        //room2 facility options
        if (document.getElementById('checkbox_noPreferences2').checked) {// if user selects 'no' facilities required, then all set to default false 
            var comp2 = false; //computer
            var ddp2 = false;    //Dual Data projection
            var dp2 = false;    //Data Projection
            var il2 = false;    //Induction Loop
            var mp2 = false;    //Media Player
            var pa2 = false;    //PA
            var plasma2 = false;  //Plasma
            var rev2 = false;    //ReView
            var mic2 = false;     //Radio Microphone
            var vis2 = false;    //Visualiser
            var wc2 = false;  //Wheelchair Access
            var wb2 = false;      //Whiteboard
        } else {    //if user selects 'yes' they do want to specify facilities
            //room preference selections, such as whiteboard
            var comp2 = document.getElementById('checkbox_COMP2').checked;    //computer 
            var ddp2 = document.getElementById('checkbox_DDP2').checked;     //Dual Data projection
            var dp2 = document.getElementById('checkbox_DP2').checked;      //Data Projection
            var il2 = document.getElementById('checkbox_IL2').checked;      //Induction Loop
            var mp2 = document.getElementById('checkbox_MP2').checked;      //Media Player
            var pa2 = document.getElementById('checkbox_PA2').checked;      //PA
            var plasma2 = document.getElementById('checkbox_PLASMA2').checked;  //Plasma
            var rev2 = document.getElementById('checkbox_REV2').checked;     //ReView
            var mic2 = document.getElementById('checkbox_MIC2').checked;      //Radio Microphone
            var vis2 = document.getElementById('checkbox_VIS2').checked;     //Visualiser
            var wc2 = document.getElementById('checkbox_Wchair2').checked;  //Wheelchair Access
            var wb2 = document.getElementById('checkbox_WB2').checked;      //Whiteboard
        }

        //room3 facility options
        if (document.getElementById('checkbox_noPreferences3').checked) {// if user selects 'no' facilities required, then all set to default false 
            var comp3 = false; //computer
            var ddp3 = false;    //Dual Data projection
            var dp3 = false;    //Data Projection
            var il3 = false;    //Induction Loop
            var mp3 = false;    //Media Player
            var pa3 = false;    //PA
            var plasma3 = false;  //Plasma
            var rev3 = false;    //ReView
            var mic3 = false;     //Radio Microphone
            var vis3 = false;    //Visualiser
            var wc3 = false;  //Wheelchair Access
            var wb3 = false;      //Whiteboard
        } else {    //if user selects 'yes' they do want to specify facilities
            //room preference selections, such as whiteboard
            var comp3 = document.getElementById('checkbox_COMP3').checked;    //computer 
            var ddp3 = document.getElementById('checkbox_DDP3').checked;     //Dual Data projection
            var dp3 = document.getElementById('checkbox_DP3').checked;      //Data Projection
            var il3 = document.getElementById('checkbox_IL3').checked;      //Induction Loop
            var mp3 = document.getElementById('checkbox_MP3').checked;      //Media Player
            var pa3 = document.getElementById('checkbox_PA3').checked;      //PA
            var plasma3 = document.getElementById('checkbox_PLASMA3').checked;  //Plasma
            var rev3 = document.getElementById('checkbox_REV3').checked;     //ReView
            var mic3 = document.getElementById('checkbox_MIC3').checked;      //Radio Microphone
            var vis3 = document.getElementById('checkbox_VIS3').checked;     //Visualiser
            var wc3 = document.getElementById('checkbox_Wchair3').checked;  //Wheelchair Access
            var wb3 = document.getElementById('checkbox_WB3').checked;      //Whiteboard
        }
        var weeks = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
        var weekChecked = 12; //12 weeks checked automatically

        if (document.getElementById('defaultWeeksNo').checked == true) {    //if user has selected to choose own weeks
            //check to see if any weeks have been selected.
            weeks = []; //sets the weeks array to empty, so can add the specific weeks user chooses.
            var weekChecked = 0;
            for (i = 1; i < 16; i++) {
                if (document.getElementById('week' + i).checked == true) {
                    weekChecked = weekChecked + 1; //if at least 1 week has been checked, then weekChecked set to true
                    weeks.push(i); //corresponding week number will be added to the array if it has been checked
                    /*
                      If at least 1 week has been checked, then checked weeks set to true.
                      Otherwise, no weeks have been selected. User must be notified.
                  */
                }
            }
        }

        var specialR = $('#specialR').val();
        var room1 = document.getElementById('select_room').value;
        var room2 = document.getElementById('select_room2').value;
        var room3 = document.getElementById('select_room3').value;

        var parkID1 = "";
        var parkID2 = "";
        var parkID3 = "";

        if (document.getElementById('checkbox_centralPark').checked) {
            parkID1 = "C";
        }
        if (document.getElementById('checkbox_westPark').checked) {
            parkID1 = "W";
        }
        if (document.getElementById('checkbox_eastPark').checked) {
            parkID1 = "E";
        }
        if (document.getElementById('checkbox_centralPark2').checked) {
            parkID2 = "C";
        }
        if (document.getElementById('checkbox_westPark2').checked) {
            parkID2 = "W";
        }
        if (document.getElementById('checkbox_eastPark2').checked) {
            parkID2 = "E";
        }
        if (document.getElementById('checkbox_centralPark3').checked) {
            parkID3 = "C";
        }
        if (document.getElementById('checkbox_westPark3').checked) {
            parkID3 = "W";
        }
        if (document.getElementById('checkbox_eastPark3').checked) {
            parkID3 = "E";
        }
        var buildingID1 = document.getElementById('select_building').value;
        var buildingID2 = document.getElementById('select_building2').value;
        var buildingID3 = document.getElementById('select_building3').value;

        roomType1 = "";
        roomType2 = "";
        roomType3 = "";
        if (document.getElementById('checkbox_Lecture').checked) {
            roomType1 = "T"
        }
        if (document.getElementById('checkbox_Seminar').checked) {
            roomType1 = "S"
        }
        if (document.getElementById('checkbox_Lab').checked) {
            roomType1 = "L"
        }
        if (document.getElementById('checkbox_Lecture2').checked) {
            roomType2 = "T"
        }
        if (document.getElementById('checkbox_Seminar2').checked) {
            roomType2 = "S"
        }
        if (document.getElementById('checkbox_Lab2').checked) {
            roomType2 = "L"
        }
        if (document.getElementById('checkbox_Lecture3').checked) {
            roomType3 = "T"
        }
        if (document.getElementById('checkbox_Seminar3').checked) {
            roomType3 = "S"
        }
        if (document.getElementById('checkbox_Lab3').checked) {
            roomType3 = "L"
        }

        var modcode = $('#modcodeInput').val().toUpperCase();   //i.e. COA101
        var modname = $('#modnameInput').val(); //i.e. Fine Art

        var day = $('#daySelect').val();    //i.e. 1
        var dayString = document.getElementById('daySelect').options[document.getElementById('daySelect').value - 1].text; //i.e. monday instead of 1

        var startTimeString = document.getElementById('select_startTime').options[document.getElementById('select_startTime').value - 1].text;//i.e. 10:00 instead of 2
        var endTimeString = document.getElementById('select_endTime').options[document.getElementById('select_endTime').value - 2].text;//i.e. 10:00 instead of 2
        var startTime = document.getElementById('select_startTime').value; //1-9
        var endTime = document.getElementById('select_endTime').value; //2-10

        var numRooms = $('#numRooms').val();
        var roomCap1 = $('#capacityInput').val();
        var roomCap2 = $('#capacityInput2').val();
        var roomCap3 = $('#capacityInput3').val();

        var capacity = +roomCap1;

        if (numRooms == 2) {
            capacity = +roomCap1 + +roomCap2;
        }
        if (numRooms == 3) {
            capacity = +roomCap1 + +roomCap2 + +roomCap3;   //unary plus operator, converts string to number                }
        }

        var defaultWeeks = 1;
        if (document.getElementById('defaultWeeksNo').checked) {    //if user selects to check own custom weeks, does not want default weeks
            defaultWeeks = 0;
        }
        /*
             var comp = false; //computer
            var ddp = false;    //Dual Data projection
            var dp = false;    //Data Projection
            var il = false;    //Induction Loop
            var mp = false;    //Media Player
            var pa = false;    //PA
            var plasma = false;  //Plasma
            var rev = false;    //ReView
            var mic = false;     //Radio Microphone
            var vis = false;    //Visualiser
            var wc = false;  //Wheelchair Access
            var wb = false;      //Whiteboard
        */

        $.ajax({
            type: "POST",
            url: "Request.aspx/SubmitRequest",
            data: JSON.stringify({
                modname: modname, modcode: modcode, day: day, startTime: startTime, endTime: endTime,
                numRooms: numRooms, roomCap1: roomCap1, roomCap2: roomCap2, roomCap3: roomCap3, capacity: capacity,
                lecturerName1: lecturerName1, lecturerName2: lecturerName2, lecturerName3: lecturerName3, specialR: specialR,
                priority: priority, parkID1: parkID1, parkID2: parkID2, parkID3: parkID3, room1: room1, room2: room2, room3: room3,
                buildingID1: buildingID1, buildingID2: buildingID2, buildingID3: buildingID3, roomType1: roomType1, roomType2: roomType2,
                roomType3: roomType3, defaultWeeks: defaultWeeks, weeks: weeks,
                comp: comp, ddp: ddp, dp: dp, il: il, mp: mp, pa: pa, plasma: plasma, rev: rev, mic: mic, vis: vis, wc: wc, wb: wb,
                comp2: comp2, ddp2: ddp2, dp2: dp2, il2: il2, mp2: mp2, pa2: pa2, plasma2: plasma2, rev2: rev2, mic2: mic2, vis2: vis2, wc2: wc2, wb2: wb2,
                comp3: comp3, ddp3: ddp3, dp3: dp3, il3: il3, mp3: mp3, pa3: pa3, plasma3: plasma3, rev3: rev3, mic3: mic3, vis3: vis3, wc3: wc3, wb3: wb3,
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("There has been an error with your request \n\nRequest: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                //alert(result.d);   //have to write as result.d for some reason
                showValidation();
                $('#messageContents').html(result.d);
            }
        });
    });


    /*
        returns true if a match exists in the db. False otherwise.
    */

    function validateLecturer(number) {
        //var lecturer = $('#lecturerInput').val();
        var lecturer = $('#lecturer' + number).html();

        var lecturerName = lecturer;
        flag = false;

        if (lecturer.indexOf('(') != -1) {
            lecturerName = lecturer.substring(0, lecturer.indexOf('('));
        }

        $.ajax({
            async: false,
            type: "POST",
            url: "Request.aspx/ValidateLecturer",
            data: JSON.stringify({ lecturerName: lecturerName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("ERROR \n" + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                if (result.d != "") {
                    flag = true;
                }
            }
        });
        return flag;
    }

    /* 
        disables, or re-enables user input into the form
        If parameter is 'true', input is enabled
        if parameter is 'false', input is disabled
    */
    function formInputEnabled(decision) {
        var status = false;
        if (decision == "false") {
            status = true;
        }
        document.getElementById('modcodeInput').disabled = status;
        document.getElementById('modnameInput').disabled = status;
        document.getElementById('daySelect').disabled = status;
        document.getElementById('select_startTime').disabled = status;
        document.getElementById('select_endTime').disabled = status;
        document.getElementById('numRooms').disabled = status;
        document.getElementById('defaultWeeksYes').disabled = status;
        document.getElementById('defaultWeeksNo').disabled = status;
        document.getElementById('submitButton').disabled = status;
        document.getElementById('preferencesButton').disabled = status;

    }



}); //document.ready closing tag

var numLecturer = 0;
function addLecturer() {
    var input = $('#lecturerInput').val();
    if ($('#lecturer1').html() == "") { //if slot empty
        $('#lecturer1').html(input);
        $('#lecturer1').show();
        numLecturer = 1;

    }
    else if ($('#lecturer2').html() == "") {    //if lecturer2 slot empty
        $('#lecturer2').html(input);
        $('#lecturer2').show();
        numLecturer = 2;

    }
    else {    //if lecturer3 slot empty
        $('#lecturer3').html(input);
        $('#lecturer3').show();
        numLecturer = 3;

    }
}

function removeLecturer() {
    if ($('#lecturer3').html() != "") { //if slot not empty
        $('#lecturer3').html("");
        $('#lecturer3').hide();
        numLecturer = 2;

    }
    else if ($('#lecturer2').html() != "") { //if slot not empty
        $('#lecturer2').html("");
        $('#lecturer2').hide();
        numLecturer = 1;

    } else {
        $('#lecturer1').html("");
        $('#lecturer1').hide();
        numLecturer = 0;

    }
}




