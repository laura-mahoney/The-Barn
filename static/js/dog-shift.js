
"use strict";
// this needs to happen for every dog
// on click each dog form needs to pop up 

// var $ = require('jquery');



$(document).ready(function(){

var proclicks = 0;
//this function shows and hides the intake information for a given dog on the barn page
function showIntakeData(evt){
    var currentDogProfile = evt.target.attributes['data-dog'].value;
    $('.dogIntakeProfile').hide();
    
    if(proclicks%2 == 0){
        $('.dogIntakeProfile').hide();
        $("#" + currentDogProfile).show();
        proclicks = proclicks + 1;
    } else {
        $("#" + currentDogProfile).hide();
        proclicks = proclicks + 1;
    };
}

$(".dogProfile").on("click", showIntakeData);



// this function creates a shift when button is hit, now it needs to send time
// and duration to the server
// function successShift(){
//     console.log('Shift successfully created');
// }

// function createShift(evt){
//     evt.preventDefault();

//     var shiftData = {
//         "time": $("#shiftTime").attr('value'),
//         "duration": $("#shiftDuration").attr('value')
//     };
//     console.log(shiftData);
//     debugger;

//     $.post("/addnotes", shiftData, successShift);

// }

// $("#createshift").on("click", createShift);



// this function shows and hides the dog form when clicked on the notes page
var clicks = 0;

function showDogForm(evt){
    var currentDogId = evt.target.attributes['data-dog'].value;
    $('.dogForm').hide();
    
    if(clicks%2 == 0){
        $('.dogForm').hide();
        $("#" + currentDogId).show();
        clicks = clicks + 1;
    } else {
        $("#" + currentDogId).hide();
        clicks = clicks + 1;
    };

};

$(".dogNames").on("click", showDogForm);



// ///////////this function adds form data/pupdates to the database
function pupdateSuccess(){
    $('.dogForm').hide();
    console.log('Successfully Pupdated!');
}

function addPupdates(evt){
    evt.preventDefault();

    var dogInput = $(this).serializeArray();
    console.log(dogInput);

    debugger;

    var dogData = {};

    for(var i = 0; i<dogInput.length; i++){
        dogData[dogInput[i].name] = dogInput[i].value;
        // debugger;
        // console.log(dogInput[i]);
    };
    // console.log(dogData);

    $.post("/dog/notes.json", dogData, pupdateSuccess);

    // dogData.append(dogInput);
    // console.log(dogData);
};

$(".pupdateForm").submit(addPupdates);




// /////////////////this function will submit general notes for the shift to the database
// function noteSuccess(){
//     console.log('General notes added for this shift.');

// };

// function submitShiftNotes(evt){
//     evt.preventDefault();
    
//     var generalNotes = $(this).serializeArray();
//     var data = {'generalNotes': generalNotes[0].value, 'shift_id': shift_id};


//     $.post("/submitnotes", data, noteSuccess);
// };
    
// $("#generalNotes").submit(submitShiftNotes);


});




