
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



// this function creates a shift when button is hit
function createShift(evt){
    evt.preventDefault();

    var shiftData = {
        "time": $("#time").val()
    }

    $.post("/addnotes", shiftData);

}

$("#createshift").on("click", createShift);



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



// this function adds form data/pupdates to the database
function pupdateSuccess(){
    flash('Successfully Updated!');
}

function addPupdates(evt){
    evt.preventDefault();

    var dogInput = {
        "dogmountain": $("#dogmountain").val(),
        "flirtpole": $("#flirtpole").val(),
        "drills": $("#drills").val(),
        "leash": $("#leash").val(),
        "pushups": $("#pushups").val(),
        "fetch": $("#fetch").val(),
        "wait": $("#wait").val(),
        "sit": $("#sit").val(),
        "down": $("#down").val(),
        "drop": $("#drop").val(),
        "leaveit": $("#leaveit").val(),
        "shake": $("#shake").val(),
        "stay": $("#stay").val(),
        "pupdatenotes": $("pupdatenotes").val(),
        "shift-id": $("shift-id").val(),
        "dog-id": $("dog-id").val()
    };

    $.post("/dog/notes", dogInput, pupdateSuccess);

    // dogData.append(dogInput);
    // console.log(dogData);
}

$("#pupdateForm").submit(addPupdates);

// function addPupdates(results){
//     var status = results;
//     ("#pupdateForm")
// }


// function sendPupdate(){

//     $.get("#pupdateForm").submit(function(evt){
//     var values = $(this).serialize();
//     dogData.append(values);
//     console.log(dogData);
// })


// $("#pupdateForm").on('click', addPupdates);

// this function will submit general notes for the shift to the database
// function submitShiftNotes()

});




