
"use strict";
// this needs to happen for every dog
// on click each dog form needs to pop up 


var alldogs = $(".dogForm")

// $("").on("click", )

function toggleDogPage(){

}


function addDogNotes(){
    $.post('/add_dog_notes.json', doginput)

    var doginput ={
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
        "stay": $("#stay").val()
    }
}

$("#pupdatenotes").on("submit", captureDogData)
