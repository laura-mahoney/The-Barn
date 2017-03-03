
"use strict";



$(document).ready(function(){

var proclicks = 0;
//this function shows and hides the intake information for a given dog on the barn page
function showIntakeData(evt){
    $('.dogIntakeProfile').hide();
   
    var allDogs = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
    var thisDog = evt.target.attributes['data-dog'].value;

    for(var i = 0; i<=allDogs.length; i++){
        if(i != thisDog){
            $("#dogp" + i).fadeTo("slow", 0.33)
        };
    };

    var currentDogProfile = evt.target.attributes['data-dog'].value;
    
    if(proclicks%2 == 0){
        $('.dogIntakeProfile').hide();
        $("#" + currentDogProfile).show();
        proclicks = proclicks + 1;

    } else {
        $("#" + currentDogProfile).hide();
        proclicks = proclicks + 1;
        $('.dogPicture').fadeTo("fast", 1);
    };


}

$(".dogPicture").on("click", showIntakeData);





// success function shows dog report
function playmatesReceived(data){
    console.log("Id received from server");
    makeTreeGraph(data);
};
//an AJAX get request that searches the database for all the dog's playmates to display
function checkPlaymates(evt){
    evt.preventDefault();

    var currentDogId = {'currentDogId': evt.target.attributes['data-dog'].value};
    
    $.post("/playmates.json", currentDogId, playmatesReceived);

};


$(".dogPicture").on('click', checkPlaymates);







// this function shows and hides the dog form when clicked on the notes page
var clicks = 0;

function showDogForm(evt){
    var currentDogId = evt.target.attributes['data-dog'].value;
    $('.dogForm').hide();
    console.log()
    if(clicks%2 == 0){
        $('.dogForm').hide();
        $("#" + currentDogId).show();
        clicks = clicks + 1;
    } else {
        $("#" + currentDogId).hide();
        clicks = clicks + 1;
    };
    console.log(currentDogId);

};

$(".dogNames").on("click", showDogForm);





// ///////////this function adds form data/pupdates to the database
function pupdateSuccess(){
    $('.dogForm').hide();
    // $(this).prop("disabled", true); test this 
    console.log('Successfully Pupdated!');
}

function addPupdates(evt){
    evt.preventDefault();

    var dogInput = $(this).serializeArray();
    console.log(dogInput);

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





// //an AJAX get request that calculates all scores of dogs and displays number
// function displayCommandsScore(){
    
//     $.get()
// };




// //an AJAX get request that reports all actvities over a week for a specific dog
// function reportCommandsScore(){
//     return true
// };



});




