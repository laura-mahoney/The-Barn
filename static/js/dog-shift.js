
"use strict";
// this needs to happen for every dog
// on click each dog form needs to pop up 

// var $ = require('jquery');

console.log("hiiiii");

$(document).ready(function(){

var clicks = 0;
function showDogForm(evt){
    
    var currentDogId = evt.target.attributes['data-dog'].value;

    if(clicks%2 == 0){
        $("#" + currentDogId).show();
        clicks = clicks + 1;
    } else {
        $("#" + currentDogId).hide();
        clicks = clicks + 1;
    };

    // var otherDogIds = $("#id");
    // otherDogIds.hide()

    // console.log(dogid);
    // $(".dogForm")
};

$(".dogNames").on("click", showDogForm);

// function toggleDogPage(){

// }


// function addDogNotes(){
//     $.post('/add_dog_notes.json', doginput)

//     var doginput ={
//         "dogmountain": $("#dogmountain").val(),
//         "flirtpole": $("#flirtpole").val(),
//         "drills": $("#drills").val(),
//         "leash": $("#leash").val(),
//         "pushups": $("#pushups").val(),
//         "fetch": $("#fetch").val(),
//         "wait": $("#wait").val(),
//         "sit": $("#sit").val(),
//         "down": $("#down").val(),
//         "drop": $("#drop").val(),
//         "leaveit": $("#leaveit").val(),
//         "shake": $("#shake").val(),
//         "stay": $("#stay").val()
//     }
// }

// $("#pupdatenotes").on("submit", captureDogData)

});
