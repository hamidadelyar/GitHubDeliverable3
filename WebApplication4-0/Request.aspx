<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Request.aspx.cs" Inherits="WebApplication4_0.Request" %>



<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
 
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui-1.8.24.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="Content/PopupBlur.css" />
    <link rel="stylesheet" href="Content/Request.css" /> <!-- Styling for the Request page-->
    <script type="text/javascript" src="Scripts/Request.js"></script> <!-- Javascript functions for the Request page -->

    <div id="requestContainer">
        <h2 id="title"style="color:white; text-align:center; font-family: 'Segoe UI',Verdana,Helvetica,sans-serif">MODULE DETAILS</h2>

        <div id="contentContainer" style="background-color:white; position:relative; top:1%; height:90%; border-bottom-left-radius: 8px; border-bottom-right-radius: 8px;">
            <table id="modDetails">
            
                <tr>
                    <td>
                        <asp:Label ID="modcodeLabel" ToolTip="Enter a module code i.e. COA123" runat="server" Text="MODULE CODE"></asp:Label>
                    </td>
                    <td>
                        <input type="text" id="modcodeInput" style="width: 200%;" placeholder="e.g. COA101"/>

                    </td>

                    <td>
                        <!--empty -->
                    </td>

                    <td>
                        <asp:Label ID="modnameLabel" runat="server" Text="MODULE NAME" ToolTip="Enter a module name i.e. Server Side Programming"></asp:Label>
                    </td>
                    <td>
                        <input type="text" id="modnameInput" style="width: 200%;" placeholder="e.g. Essential Skills for Computing"/>
                    </td>
                    <td>
                        <!-- empty -->
                    </td>
                </tr>

                <!--
                <tr>
                   
                   
                 
                </tr>
                    -->
                <tr>
                    <td>
                        <asp:Label ID="daySelectLabel" runat="server" Text="DAY" ToolTip="Select the day that you would like to make the booking for"></asp:Label>
                    </td>
                    <td>
                        <div class="styled-select">
                            <select id="daySelect">
                                <option value="1">Monday</option>
                                <option value="2">Tuesday</option>
                                <option value="3">Wednesday</option>
                                <option value="4">Thursday</option>
                                <option value="5">Friday</option>
                            </select>
                        </div>
                    </td>

                    <td>
                        <asp:Label ID="startTimeLabel" runat="server" Text="START TIME" ToolTip="Select the time that you would like the lecture to start i.e. 10:00"></asp:Label>
                        <asp:Label ID="startPeriodLabel" runat="server" Text="START PERIOD" style="display:none" ToolTip="Select the period that you would like the lecture to start i.e. 2"></asp:Label>
                        <img id="changeTime" src="/Images/changeTime.png" style="width:20px; height:20px; margin-left:5px; cursor:pointer"/>
                        
                    </td>
                    <td>
                        <div class="styled-select">
                            <select id="select_startTime">
                                <option value="1">9:00</option>
                                <option value="2">10:00</option>
                                <option value="3">11:00</option>
                                <option value="4">12:00</option>
                                <option value="5">13:00</option>
                                <option value="6">14:00</option>
                                <option value="7">15:00</option>
                                <option value="8">16:00</option>
                                <option value="9">17:00</option>
                            </select>
                        </div>
                    </td>

                    <td>
                        <asp:Label ID="endTimeLabel" runat="server" Text="END TIME" ToolTip="Select the time that you would like the lecture to end i.e. 11:00"></asp:Label>
                        <asp:Label ID="endPeriodLabel" runat="server" Text="END PERIOD" style="display:none" ToolTip="Select the period that you would like the lecture to end i.e. 5"></asp:Label>
                    </td>
                    <td>
                        <div class="styled-select">
                            <select id="select_endTime">
                                <option value="2">10:00</option>
                                <option value="3">11:00</option>
                                <option value="4">12:00</option>
                                <option value="5">13:00</option>
                                <option value="6">14:00</option>
                                <option value="7">15:00</option>
                                <option value="8">16:00</option>
                                <option value="9">17:00</option>
                                <option value="10">18:00</option>
                            </select>
                        </div>
                    </td>
                </tr>


                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="NUMBER OF ROOMS" ToolTip="Select the number of rooms that you would like for this booking."></asp:Label>
                    </td>
                    <td>
                        <div class="styled-select">
                            <select id="numRooms">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                            </select>
                        </div>
                    </td>

         
                     <td>
                         <asp:Label ID="priorityLabel" ToolTip="Is this a priority request?" runat="server" Text="PRIORITY"></asp:Label>
                    </td>
                    <td>
                        <div class="divClass">
                             <input type="radio" name="priority" id="priorityNo" class="radio" checked />
                            
                            <label for="priorityNo">No</label>
                        </div>
                        <div class="divClass">
                            <input type="radio" name="priority" id="priorityYes" class="radio"  />
                           
                            <label for="priorityYes">Yes</label>
                        </div>
                    </td>
                    <td colspan="2">
                      
                    </td>
                    
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lecturerLabel" ToolTip="Enter the name of the lecturer i.e. John Smith" runat="server" Text="LECTURER"></asp:Label>
                    </td>

                    <td style="width:150%">
                        <input id="lecturerInput" type="text" style="width:150%; margin-left:0px; " placeholder="e.g. John Smith"/>
                    </td>

                    <td>
                       <img id="lecturerAdd" src="Images/add.png" style="width:30px; height:30px; margin-left:30px; cursor: pointer;" onclick="addLecturer();"/>
                        <br />
                        <img id="lecturerRemove" src="Images/minus.png" style="width:30px; height:30px; margin-left:30px; cursor:pointer;" onclick="removeLecturer();"/>
                      
                       
                    </td>
                    <td>
                        
                       
                        <input type="button" id="preferencesButton" value="Preferences" class="orangeButton" style="font-size:1.5em; margin: auto; width: 120%; display:block; margin-left: 30%"/>
                    </td>
                    <td>
                       <input type="button" id="submitButton" value="Submit" style="margin-bottom:0px; width:120%; position:relative; margin-left: 60%; top: -2px;"  class="greenButton"/>
                    </td>
                   
                </tr>

            </table>
        

        <!-- preference table for room 1, room 2 and room 3-->

        <table id="preferenceTable" class="preferenceTable" style="display:none">
             <tr>
                 <td>
                    <asp:Label ID="capacityLabel" for="capacityInput" runat="server" Text="NUMBER OF STUDENTS" ToolTip="Enter total number of students on the module"></asp:Label>
                </td>
                <td>
                    <input type="text" id="capacityInput" value='30'/>
                </td>
                <td>
                    <asp:Label ID="roomType" runat="server" Text="ROOM TYPE" ToolTip="Select the room type you would like to book"></asp:Label>
                </td>
               
                 <td>
                     
                     <div class="divClassCheckbox roomTypeClass">
                         <input type="radio" id="checkbox_Lecture" name="roomType1" class="radio" checked /> <!-- all checked by default -->
                         <label for="checkbox_Lecture">Lecture</label>
                     </div>
                     <div class="divClassCheckbox roomTypeClass">
                         <input type="radio" id="checkbox_Seminar" name="roomType1" class="radio" />
                         <label for="checkbox_Seminar">Seminar</label>
                     </div>
                      <div class="divClassCheckbox roomTypeClass">
                         <input type="radio" id="checkbox_Lab" name="roomType1" class="radio" />
                         <label for="checkbox_Lab">Lab</label>
                     </div>
                 </td>  

                 <td>
                     <asp:Label ID="Label4" runat="server" Text="PARK" ToolTip="Select your preferred park(s)"></asp:Label>
                 </td>

                 <td>
                     <div class="divClassCheckbox parkClass">  
                         <input type="radio" name="park1" id="checkbox_centralPark"  class="radio" checked/>
                         <label for="checkbox_centralPark">Central</label>
                     </div>
                     <div class="divClassCheckbox parkClass">  
                         <input type="radio" name="park1" id="checkbox_westPark" class="radio"/>
                         <label for="checkbox_westPark">West</label>
                     </div>
                     <div class="divClassCheckbox parkClass">  
                         <input type="radio" name="park1" id="checkbox_eastPark" class="radio"/>
                         <label for="checkbox_eastPark">East</label>
                     </div>
                 </td>

            </tr>

            <tr>
             
         

                <td>
                    <asp:Label ID="defaultWeeksLabel" runat="server" Text="DEFAULT WEEKS?" ToolTip="Default weeks are weeks 1 to 12. if you wish to choose the specific weeks yourself, select 'No'."></asp:Label>
                </td>
                <td>
                    <div class="divClass">
                        <input type="radio" name="radioWeek" id="defaultWeeksYes" class="radio" checked />
                        <!-- checked by default -->
                        <label for="defaultWeeksYes">Yes</label>
                    </div>
                    <div class="divClass">
                        <input type="radio" name="radioWeek" id="defaultWeeksNo" class="radio" />
                        <label for="defaultWeeksNo">No</label>
                    </div>
                </td>

                <td>
                    <asp:Label ID="Label8" runat="server" Text="REQUEST ROOM FACILITIES?" ToolTip="Select the preferences that you would like"></asp:Label>
                </td>
                <td>
                   <div class="divClass requestFacilitiesClass">
                       <input type="radio" name="preferenceRadio" class="radio" id="checkbox_noPreferences" checked />
                       <label for="checkbox_noPreferences">No</label>
                   </div>
                     <div class="divClass requestFacilitiesClass">
                       <input type="radio" name="preferenceRadio" class="radio" id="checkbox_yesPreferences" />
                       <label for="checkbox_yesPreferences">Yes</label>
                   </div>
                </td>   

                <td>
                    <asp:Label ID="Label5" runat="server" Text="BUILDING" style="position:relative; top:8px"></asp:Label>
                    <br /><br /><br />
                    <asp:Label ID="room1_label" runat="server" Text="ROOM" style="position:relative; top:8px"></asp:Label>
                </td>

                <td>
                    <div class="styled-select" style="width:150%; position:relative; left: -20%; margin-top:28px; margin-bottom:20px">
                        <select id="select_building">
                            <!-- options filled with AJAX -->
                        </select>
                    </div>
                    <div class="styled-select" style="width:150%; position:relative; left: -20%;  margin-top:20px; margin-bottom:20px">
                        <select id="select_room">
                            <!-- options filled with AJAX -->
                         </select>
                    </div>
                </td>

            </tr>
           
            <tr>
                <td>
                    <input type="button" id="preferencesDoneButton" value="Done" class="orangeButton" />
                </td>
                <td>
                    <!-- empty - formatting -->
                </td>
                <td>
                    <input type="button" id="gotoRoom2" value="Next Room"/>
                </td>
            </tr>
        </table>
            <table id="lecturerRowTable" style="width:95%; margin-top:0px; table-layout: fixed; margin-left:2.5%; font-weight:100; text-align:center">
                <tr>
                      <td colspan="3">
                         <ul style="width:100%; padding:0;">
                            <li id="lecturer1" style="display:none"></li>
                            <li id="lecturer2" style="display:none"></li>
                            <li id="lecturer3" style="display:none"></li>
                        </ul> 
                    </td>
                   
                </tr>
            </table>

        <!-- preferences for 2nd room selection. Only selectable if user selects that they want to book 2 rooms.  -->
         <table id="preferenceTable2" class="preferenceTable" style="display:none">
           <tr>
                 <td>
                    <asp:Label ID="capacity2Label" for="capacityInput2" runat="server" Text="NUMBER OF STUDENTS" ToolTip="Enter total number of students on the module"></asp:Label>
                </td>
                <td>
                    <input type="text" id="capacityInput2"  value="30" />
                </td>
                <td>
                    <asp:Label ID="Label9" runat="server" Text="ROOM TYPE" ToolTip="Select the room type you would like to book"></asp:Label>
                </td>
               
                 <td>
                     
                     <div class="divClassCheckbox roomTypeClass2">
                         <input type="radio" id="checkbox_Lecture2" class="radio" name="roomType2" checked /> 
                         <label for="checkbox_Lecture2">Lecture</label>
                     </div>
                     <div class="divClassCheckbox roomTypeClass2">
                         <input type="radio" id="checkbox_Seminar2" name="roomType2" class="radio" />
                         <label for="checkbox_Seminar2">Seminar</label>
                     </div>
                      <div class="divClassCheckbox roomTypeClass2">
                         <input type="radio" id="checkbox_Lab2" name="roomType2" class="radio" />
                         <label for="checkbox_Lab2">Lab</label>
                     </div>
                 </td>  

                 <td>
                     <asp:Label ID="Label10" runat="server" Text="PARK" ToolTip="Select your preferred park(s)"></asp:Label>
                 </td>

                 <td>
                     <div class="divClassCheckbox parkClass2">  
                         <input type="radio" name="park2" id="checkbox_centralPark2" class="radio" checked/>
                         <label for="checkbox_centralPark2">Central</label>
                     </div>
                     <div class="divClassCheckbox parkClass2">  
                         <input type="radio" name="park2" id="checkbox_westPark2" class="radio"/>
                         <label for="checkbox_westPark2">West</label>
                     </div>
                     <div class="divClassCheckbox parkClass2">  
                         <input type="radio" name="park2" id="checkbox_eastPark2" class="radio"/>
                         <label for="checkbox_eastPark2">East</label>
                     </div>
                 </td>

            </tr>

            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" Text="DEFAULT WEEKS?" ToolTip="Default weeks are weeks 1 to 12. if you wish to choose the specific weeks yourself, select 'No'."></asp:Label>
                </td>
                <td>
                    <div class="divClass">
                        <input type="radio" name="radioWeek2" id="defaultWeeksYesTwo" class="radio" checked />
                        <!-- checked by default -->
                        <label for="defaultWeeksYesTwo">Yes</label>
                    </div>
                    <div class="divClass">
                        <input type="radio" name="radioWeek2" id="defaultWeeksNoTwo" class="radio" />
                        <label for="defaultWeeksNoTwo">No</label>
                    </div>
                </td>
                

                <td>
                     <asp:Label ID="Label11" runat="server" Text="REQUEST ROOM FACILITIES?" ToolTip="Select the preferences that you would like"></asp:Label>
                </td>
                <td>
                   <div class="divClass requestFacilitiesClass2">
                       <input type="radio" name="preferenceRadio2" class="radio" id="checkbox_noPreferences2" checked />
                       <label for="checkbox_noPreferences2">No</label>
                   </div>
                     <div class="divClass requestFacilitiesClass2">
                       <input type="radio" name="preferenceRadio2" class="radio" id="checkbox_yesPreferences2" />
                       <label for="checkbox_yesPreferences2">Yes</label>
                   </div>
                </td>   

         
                <td>
                    <asp:Label ID="Label12" runat="server" Text="BUILDING" style="position:relative; top:8px"></asp:Label>
                    <br /><br /><br />
                    <asp:Label ID="room2_label" runat="server" Text="ROOM" style="position:relative; top:8px"></asp:Label>
                </td>

                <td>
                    <div class="styled-select" style="width:150%; position: relative; left:-20%; margin-top:28px; margin-bottom:20px">
                        <select id="select_building2">
                            <!-- options filled with AJAX -->
                        </select>
                    </div>
                    <div class="styled-select" style="width:150%; position: relative; left:-20%;  margin-top:20px; margin-bottom:20px">
                        <select id="select_room2">
                            <!-- options filled with AJAX -->
                         </select>
                    </div>
                </td>

            </tr>
           
            <tr>
                <td>
                    <input type="button" id="preferencesDoneButton2" value="Done" class="orangeButton"/>
                </td>
                
                <td>
                    <input type="button" id="gotoPrevRoom1" value="Previous Room" />
                </td>
                <td>
                    <input type="button" id="gotoRoom3" value="Next Room"/>
                </td>
            </tr>
        </table>

         <!-- preferences for 3rd room selection. Only selectable if user selects that they want to book 3 rooms.  -->
         <table id="preferenceTable3" class="preferenceTable" style="display:none">
           <tr>
                 <td>
                    <asp:Label ID="capacity3Label" for="capacityInput3" runat="server" Text="NUMBER OF STUDENTS" ToolTip="Enter total number of students on the module"></asp:Label>
                </td>
                <td>
                    <input type="text" id="capacityInput3" value='30' placeholder="e.g. 50"  />
                </td>
                <td>
                    <asp:Label ID="Label15" runat="server" Text="ROOM TYPE" ToolTip="Select the room type you would like to book"></asp:Label>
                </td>
               
                 <td>
                     
                     <div class="divClassCheckbox roomTypeClass3">
                         <input type="radio" id="checkbox_Lecture3" name="roomType3" class="radio" checked /> <!-- all checked by default -->
                         <label for="checkbox_Lecture3">Lecture</label>
                     </div>
                     <div class="divClassCheckbox roomTypeClass3">
                         <input type="radio" id="checkbox_Seminar3" name="roomType3" class="radio" />
                         <label for="checkbox_Seminar3">Seminar</label>
                     </div>
                      <div class="divClassCheckbox roomTypeClass3">
                         <input type="radio" id="checkbox_Lab3" name="roomType3" class="radio" />
                         <label for="checkbox_Lab3">Lab</label>
                     </div>
                 </td>  

                 <td>
                     <asp:Label ID="Label16" runat="server" Text="PARK" ToolTip="Select your preferred park(s)"></asp:Label>
                 </td>

                 <td>
                     <div class="divClassCheckbox parkClass3">  
                         <input type="radio" name="park3" id="checkbox_centralPark3" class="radio" checked/>
                         <label for="checkbox_centralPark3">Central</label>
                     </div>
                     <div class="divClassCheckbox parkClass3">  
                         <input type="radio" name="park3" id="checkbox_westPark3" class="radio" />
                         <label for="checkbox_westPark3">West</label>
                     </div>
                     <div class="divClassCheckbox parkClass3">  
                         <input type="radio" name="park3" id="checkbox_eastPark3" class="radio" />
                         <label for="checkbox_eastPark3">East</label>
                     </div>
                 </td>

            </tr>

            <tr>
             
                <td>
                    <asp:Label ID="Label3" runat="server" Text="DEFAULT WEEKS?" ToolTip="Default weeks are weeks 1 to 12. if you wish to choose the specific weeks yourself, select 'No'."></asp:Label>
                </td>
                <td>
                    <div class="divClass">
                        <input type="radio" name="radioWeek3" id="defaultWeeksYesThree" class="radio" checked />
                        <!-- checked by default -->
                        <label for="defaultWeeksYesThree">Yes</label>
                    </div>
                    <div class="divClass">
                        <input type="radio" name="radioWeek3" id="defaultWeeksNoThree" class="radio" />
                        <label for="defaultWeeksNoThree">No</label>
                    </div>
                </td>
                

                <td>
                     <asp:Label ID="Label17" runat="server" Text="REQUEST ROOM FACILITIES?" ToolTip="Select the preferences that you would like"></asp:Label>
                </td>
                <td>
                   <div class="divClass requestFacilitiesClass3">
                       <input type="radio" name="preferenceRadio3" class="radio" id="checkbox_noPreferences3" checked />
                       <label for="checkbox_noPreferences3">No</label>
                   </div>
                     <div class="divClass requestFacilitiesClass3">
                       <input type="radio" name="preferenceRadio3" class="radio" id="checkbox_yesPreferences3" />
                       <label for="checkbox_yesPreferences3">Yes</label>
                   </div>
                </td>   

                <td>
                    <asp:Label ID="Label18" runat="server" Text="BUILDING" style="position:relative; top:8px"></asp:Label>
                    <br /><br /><br />
                    <asp:Label ID="room3_label" runat="server" Text="ROOM" style="position:relative; top:8px"></asp:Label>
                </td>

                <td>
                    <div class="styled-select" style="width:150%; position:relative; left: -20%; margin-top:28px; margin-bottom:20px">
                        <select id="select_building3">
                            <!-- options filled with AJAX -->
                        </select>
                    </div>
                    <div class="styled-select" style="width:150%; position:relative; left: -20%; margin-top:20px; margin-bottom:20px">
                        <select id="select_room3">
                            <!-- options filled with AJAX -->
                         </select>
                    </div>
                </td>

            </tr>
           
            <tr>
                <td>
                    <input type="button" id="preferencesDoneButton3" value="Done" class="orangeButton"/>
                </td>
      
                <td>
                    <input type="button" id="gotoPrevRoom2" value="Previous Room" />
                </td>

            </tr>
        </table>

   
        </div>
    </div>
    


<!-- popup contents for week selection-->
<div class="pop" id="popupWeeks">

    <span id="closePopup" style="cursor: pointer; left: 15px; top: -10px; font-size: 2em; display:inline-block; position:relative; ">✖</span>
    <h1 style="display:inline-block; left:140px; position:relative; color:white; top: -10px;">Week Selection</h1>  
   
    <div style="width:100%; height:90%; top:10%; background-color:#3E454D; border-bottom-left-radius:8px; border-bottom-right-radius:8px;">
       
         <table style="width:70%; height:80%; top: 5%; left:15%;position:relative; table-layout:fixed;">
            <tr>
                <td>
                    &nbsp;&nbsp; WEEK 1
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne">
                        <input type="checkbox" id="week1"/>
                        <label for="week1" ></label>
                    </div>
                </td>

                <td>
                   &nbsp;&nbsp;  WEEK 2
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week2"/>
                        <label for="week2" ></label>
                    </div>
                </td>

                <td>
                   &nbsp;&nbsp;  WEEK 3
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week3"/>
                        <label for="week3" ></label>
                    </div>
                </td>

               <td>
                  &nbsp;&nbsp;  WEEK 4
               </td>
                <td>
                     <div class="checkboxOne">
                        <input type="checkbox" id="week4"/>
                        <label for="week4" ></label>
                    </div>
                </td>
            </tr>
            
            <tr style="border-top:3px solid white; border-bottom: 3px solid white;">
                <td>
                    &nbsp;&nbsp; WEEK 5
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week5"/>
                        <label for="week5" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 6
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week6"/>
                        <label for="week6" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 7
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week7"/>
                        <label for="week7" ></label>
                    </div>
                </td>

                <td>
                   &nbsp;&nbsp;  WEEK 8
                </td>
                 <td>
                     <div class="checkboxOne">
                        <input type="checkbox" id="week8"/>
                        <label for="week8" ></label>
                    </div>
                </td>
            </tr>

            <tr style="border-top:3px solid white; border-bottom: 3px solid white;">
                <td>
                   &nbsp;&nbsp;  WEEK 9
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week9"/>
                        <label for="week9" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 10
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week10"/>
                        <label for="week10" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 11
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week11"/>
                        <label for="week11" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 12
                </td>
                 <td>
                     <div class="checkboxOne">
                        <input type="checkbox" id="week12"/>
                        <label for="week12" ></label>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    &nbsp;&nbsp; WEEK 13
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week13"/>
                        <label for="week13" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 14
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week14"/>
                        <label for="week14" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp;  WEEK 15
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week15"/>
                        <label for="week15" ></label>
                    </div>
                </td>

                <td>
                    <input type="button" value="Reset" id="resetWeeks" style="margin-left:10px; background-color:white; width: 90%; font-size: 1em; border-radius:8px"/>
                </td>
               <td>
                    <input type="button" value="Select All" id="selectAllWeeks" style="background-color:white; width: 100%; font-size: 1em; border-radius:8px"/>
               </td>
            </tr>
        </table>

    </div>
</div>



<!-- popup contents for week selection - Room2-->
<div class="pop" id="popupWeeksTwo">

    <span id="closePopupTwo" style="cursor: pointer; left: 15px; top: -10px; font-size: 2em; display:inline-block; position:relative; ">✖</span>
    <h1 style="display:inline-block; left:140px; position:relative; color:white; top: -10px;">Week Selection</h1>  
   
    <div style="width:100%; height:90%; top:10%; background-color:#3E454D; border-bottom-left-radius:8px; border-bottom-right-radius:8px;">
       
         <table style="width:70%; height:80%; top: 5%; left:15%;position:relative; table-layout:fixed;">
            <tr>
                <td>
                    &nbsp;&nbsp; WEEK 1
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne">
                        <input type="checkbox" id="week1Two"/>
                        <label for="week1Two" ></label>
                    </div>
                </td>

                <td>
                   &nbsp;&nbsp;  WEEK 2
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week2Two"/>
                        <label for="week2Two" ></label>
                    </div>
                </td>

                <td>
                   &nbsp;&nbsp;  WEEK 3
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week3Two"/>
                        <label for="week3Two" ></label>
                    </div>
                </td>

               <td>
                  &nbsp;&nbsp;  WEEK 4
               </td>
                <td>
                     <div class="checkboxOne">
                        <input type="checkbox" id="week4Two"/>
                        <label for="week4Two" ></label>
                    </div>
                </td>
            </tr>
            
            <tr style="border-top:3px solid white; border-bottom: 3px solid white;">
                <td>
                    &nbsp;&nbsp; WEEK 5
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week5Two"/>
                        <label for="week5Two" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 6
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week6Two"/>
                        <label for="week6Two" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 7
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week7Two"/>
                        <label for="week7Two" ></label>
                    </div>
                </td>

                <td>
                   &nbsp;&nbsp;  WEEK 8
                </td>
                 <td>
                     <div class="checkboxOne">
                        <input type="checkbox" id="week8Two"/>
                        <label for="week8Two" ></label>
                    </div>
                </td>
            </tr>

            <tr style="border-top:3px solid white; border-bottom: 3px solid white;">
                <td>
                   &nbsp;&nbsp;  WEEK 9
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week9Two"/>
                        <label for="week9Two" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 10
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week10Two"/>
                        <label for="week10Two" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 11
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week11Two"/>
                        <label for="week11Two" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 12
                </td>
                 <td>
                     <div class="checkboxOne">
                        <input type="checkbox" id="week12Two"/>
                        <label for="week12Two" ></label>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    &nbsp;&nbsp; WEEK 13
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week13Two"/>
                        <label for="week13Two" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 14
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week14Two"/>
                        <label for="week14Two" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp;  WEEK 15
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week15Two"/>
                        <label for="week15Two" ></label>
                    </div>
                </td>

                <td>
                    <input type="button" value="Reset" id="resetWeeksTwo" style="margin-left:10px; background-color:white; width: 90%; font-size: 1em; border-radius:8px"/>
                </td>
               <td>
                    <input type="button" value="Select All" id="selectAllWeeksTwo" style="background-color:white; width: 100%; font-size: 1em; border-radius:8px"/>
               </td>
            </tr>
        </table>

    </div>
</div>

<!-- popup contents for week selection-->
<div class="pop" id="popupWeeksThree">

    <span id="closePopupThree" style="cursor: pointer; left: 15px; top: -10px; font-size: 2em; display:inline-block; position:relative; ">✖</span>
    <h1 style="display:inline-block; left:140px; position:relative; color:white; top: -10px;">Week Selection</h1>  
   
    <div style="width:100%; height:90%; top:10%; background-color:#3E454D; border-bottom-left-radius:8px; border-bottom-right-radius:8px;">
       
         <table style="width:70%; height:80%; top: 5%; left:15%;position:relative; table-layout:fixed;">
            <tr>
                <td>
                    &nbsp;&nbsp; WEEK 1
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne">
                        <input type="checkbox" id="week1Three"/>
                        <label for="week1Three" ></label>
                    </div>
                </td>

                <td>
                   &nbsp;&nbsp;  WEEK 2
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week2Three"/>
                        <label for="week2Three" ></label>
                    </div>
                </td>

                <td>
                   &nbsp;&nbsp;  WEEK 3
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week3Three"/>
                        <label for="week3Three" ></label>
                    </div>
                </td>

               <td>
                  &nbsp;&nbsp;  WEEK 4
               </td>
                <td>
                     <div class="checkboxOne">
                        <input type="checkbox" id="week4Three"/>
                        <label for="week4Three" ></label>
                    </div>
                </td>
            </tr>
            
            <tr style="border-top:3px solid white; border-bottom: 3px solid white;">
                <td>
                    &nbsp;&nbsp; WEEK 5
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week5Three"/>
                        <label for="week5Three" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 6
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week6Three"/>
                        <label for="week6Three" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 7
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week7Three"/>
                        <label for="week7Three" ></label>
                    </div>
                </td>

                <td>
                   &nbsp;&nbsp;  WEEK 8
                </td>
                 <td>
                     <div class="checkboxOne">
                        <input type="checkbox" id="week8Three"/>
                        <label for="week8Three" ></label>
                    </div>
                </td>
            </tr>

            <tr style="border-top:3px solid white; border-bottom: 3px solid white;">
                <td>
                   &nbsp;&nbsp;  WEEK 9
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week9Three"/>
                        <label for="week9Three" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 10
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week10Three"/>
                        <label for="week10Three" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 11
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week11Three"/>
                        <label for="week11Three" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 12
                </td>
                 <td>
                     <div class="checkboxOne">
                        <input type="checkbox" id="week12Three"/>
                        <label for="week12Three" ></label>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    &nbsp;&nbsp; WEEK 13
                </td>
                <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week13Three"/>
                        <label for="week13Three" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp; WEEK 14
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week14Three"/>
                        <label for="week14Three" ></label>
                    </div>
                </td>

                <td>
                    &nbsp;&nbsp;  WEEK 15
                </td>
                 <td style="border-right:3px solid white; ">
                     <div class="checkboxOne">
                        <input type="checkbox" id="week15Three"/>
                        <label for="week15Three" ></label>
                    </div>
                </td>

                <td>
                    <input type="button" value="Reset" id="resetWeeksThree" style="margin-left:10px; background-color:white; width: 90%; font-size: 1em; border-radius:8px"/>
                </td>
               <td>
                    <input type="button" value="Select All" id="selectAllWeeksThree" style="background-color:white; width: 100%; font-size: 1em; border-radius:8px"/>
               </td>
            </tr>
        </table>

    </div>
</div>

<!-- popup contents for facility selection - Room 1-->
<div class="pop" id="popupFacilities">

    <span id="closePopupFacilities" style="cursor: pointer; left: 15px; top: -10px; font-size: 2em; display:inline-block; position:relative; ">✖</span>
    <h1 style="display:inline-block; left:140px; position:relative; color:white; top: -10px;">Facility Selection</h1>  
   
    <div style="width:100%; height:90%; top:10%; background-color:#3E454D; border-bottom-left-radius:8px; border-bottom-right-radius:8px;">
        <table style="width:70%; height:80%; top: 5%; left:15%;position:relative;">
            <tr>
                <td style="text-align:center; padding-left:5px">
                    Computer
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_COMP"/>
                        <label for="checkbox_COMP" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Dual Data Projection
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_DDP"/>
                        <label for="checkbox_DDP" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Data Projection
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_DP"/>
                        <label for="checkbox_DP" ></label>
                    </div>
                </td>

                 <td style="text-align:center; padding-left:5px">
                    Induction Loop
                </td>
                <td >
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_IL"/>
                        <label for="checkbox_IL" ></label>
                    </div>
                </td>
            </tr>

            <tr style="border-top:3px solid white; border-bottom: 3px solid white;">
                <td style="text-align:center; padding-left:5px">
                    Media Player
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_MP"/>
                        <label for="checkbox_MP" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    PA
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_PA"/>
                        <label for="checkbox_PA" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Plasma Screen
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_PLASMA"/>
                        <label for="checkbox_PLASMA" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    ReView
                </td>
                <td>
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_REV"/>
                        <label for="checkbox_REV" ></label>
                    </div>
                </td>
            </tr>

            <tr>
                <td style="text-align:center; padding-left:5px">
                    Microphone
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_MIC"/>
                        <label for="checkbox_MIC" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Visualiser
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_VIS"/>
                        <label for="checkbox_VIS" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Wheelchair
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_Wchair"/>
                        <label for="checkbox_Wchair" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Whiteboard
                </td>
                <td >
                    <div class="checkboxOne facilityCheckboxes">
                        <input type="checkbox" id="checkbox_WB"/>
                        <label for="checkbox_WB" ></label>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>


<!-- popup contents for facility selection - Room 2-->
<div class="pop" id="popupFacilities2">

    <span id="closePopupFacilities2" style="cursor: pointer; left: 15px; top: -10px; font-size: 2em; display:inline-block; position:relative; ">✖</span>
    <h1 style="display:inline-block; left:140px; position:relative; color:white; top: -10px;">Facility Selection</h1>  
   
    <div style="width:100%; height:90%; top:10%; background-color:#3E454D; border-bottom-left-radius:8px; border-bottom-right-radius:8px;">
        <table style="width:70%; height:80%; top: 5%; left:15%;position:relative;">
            <tr>
                <td style="text-align:center; padding-left:5px">
                    Computer
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_COMP2"/>
                        <label for="checkbox_COMP2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Dual Data Projection
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_DDP2"/>
                        <label for="checkbox_DDP2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Data Projection
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_DP2"/>
                        <label for="checkbox_DP2" ></label>
                    </div>
                </td>

                 <td style="text-align:center; padding-left:5px">
                    Induction Loop
                </td>
                <td >
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_IL2"/>
                        <label for="checkbox_IL2" ></label>
                    </div>
                </td>
            </tr>

            <tr style="border-top:3px solid white; border-bottom: 3px solid white;">
                <td style="text-align:center; padding-left:5px">
                    Media Player
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_MP2"/>
                        <label for="checkbox_MP2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    PA
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_PA2"/>
                        <label for="checkbox_PA2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Plasma Screen
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_PLASMA2"/>
                        <label for="checkbox_PLASMA2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    ReView
                </td>
                <td>
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_REV2"/>
                        <label for="checkbox_REV2" ></label>
                    </div>
                </td>
            </tr>

            <tr>
                <td style="text-align:center; padding-left:5px">
                    Microphone
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_MIC2"/>
                        <label for="checkbox_MIC2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Visualiser
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_VIS2"/>
                        <label for="checkbox_VIS2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Wheelchair
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_Wchair2"/>
                        <label for="checkbox_Wchair2" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Whiteboard
                </td>
                <td >
                    <div class="checkboxOne facilityCheckboxes2">
                        <input type="checkbox" id="checkbox_WB2"/>
                        <label for="checkbox_WB2" ></label>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>
    


<!-- popup contents for facility selection - Room 2-->
<div class="pop" id="popupFacilities3">

    <span id="closePopupFacilities3" style="cursor: pointer; left: 15px; top: -10px; font-size: 2em; display:inline-block; position:relative; ">✖</span>
    <h1 style="display:inline-block; left:140px; position:relative; color:white; top: -10px;">Facility Selection</h1>  
   
    <div style="width:100%; height:90%; top:10%; background-color:#3E454D; border-bottom-left-radius:8px; border-bottom-right-radius:8px;">
        <table style="width:70%; height:80%; top: 5%; left:15%;position:relative;">
            <tr>
                <td style="text-align:center; padding-left:5px">
                    Computer
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_COMP3"/>
                        <label for="checkbox_COMP3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Dual Data Projection
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_DDP3"/>
                        <label for="checkbox_DDP3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Data Projection
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_DP3"/>
                        <label for="checkbox_DP3" ></label>
                    </div>
                </td>

                 <td style="text-align:center; padding-left:5px">
                    Induction Loop
                </td>
                <td >
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_IL3"/>
                        <label for="checkbox_IL3" ></label>
                    </div>
                </td>
            </tr>

            <tr style="border-top:3px solid white; border-bottom: 3px solid white;">
                <td style="text-align:center; padding-left:5px">
                    Media Player
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_MP3"/>
                        <label for="checkbox_MP3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    PA
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_PA3"/>
                        <label for="checkbox_PA3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Plasma Screen
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_PLASMA3"/>
                        <label for="checkbox_PLASMA3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    ReView
                </td>
                <td>
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_REV3"/>
                        <label for="checkbox_REV3" ></label>
                    </div>
                </td>
            </tr>

            <tr>
                <td style="text-align:center; padding-left:5px">
                    Microphone
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_MIC3"/>
                        <label for="checkbox_MIC3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Visualiser
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_VIS3"/>
                        <label for="checkbox_VIS3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Wheelchair
                </td>
                <td style="border-right:3px solid white; ">
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_Wchair3"/>
                        <label for="checkbox_Wchair3" ></label>
                    </div>
                </td>

                <td style="text-align:center; padding-left:5px">
                    Whiteboard
                </td>
                <td >
                    <div class="checkboxOne facilityCheckboxes3">
                        <input type="checkbox" id="checkbox_WB3"/>
                        <label for="checkbox_WB3" ></label>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>
 
    <!-- box to show validation errors -->
    <div id="validationContainer" style="display:none">

            <table style="table-layout:fixed; width:100%; height:90%; position:relative; color:black;text-align:center">
                <tr>
                    <td id="messageContents" style="font-size: 1em;">
                        <!-- filled in with js depending on error -->
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="button" id="closeValidation" class="orangeButton" style="width:30%;" value="OK"/>
                    </td>
                </tr>
            </table>
    
    </div>

    <!-- box to show validation errors -->
    <div id="confirmationContainer" style="display:none">

            <table style="table-layout:fixed; width:100%; left:10px; height:90%; position:relative; color:black;text-align:center">
                <tr>
                    <td style="font-size: 1em; text-align:center" colspan="2">
                        
                    </td>
                </tr>
                <tr>
                     <td id="confirmationContents" style="font-size: 1em; text-align:center" colspan="2">
                </tr>
                <tr>
                    <td colspan="2">
                        <textarea id="specialR"style="max-height:100px; max-width:92%; min-width:40%; color: black; position:relative; text-align:center;"  wrap="soft" placeholder="Please enter any 'Special Requirements' here."></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        Please double check the details above to ensure that they are correct. If you are happy, click 'Yes' to submit.
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="button" id="submitRequest" class="greenButton" style="width:30%; float:right;" value="Yes"/>
                    </td>
                    <td>
                        <input type="button" id="cancelRequest" class="orangeButton" style="width:30%; float:left;" value="No" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        Alternatively, If you would like to submit this as an AdHoc Request, click the button below.
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="button" id="adhocButton" value="AdHoc" class="blueButton" style="width:15%;" />
                    </td>
                </tr>
            </table>
    
    </div>
</asp:Content>
