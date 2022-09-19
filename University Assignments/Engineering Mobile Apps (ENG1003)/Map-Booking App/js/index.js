"use strict";

/*
* Authors:  1. Hor Zu Hui
*           2. Zareh Kozanian
*           3. Chia Zer
*           4. LAHIRU HASARANGA WELIWITIYA
* University: Monash University Malaysia
* Degree: E3001 Bachelor of Engineering (Honours) 
* Last modified: 21 May 2021
* Purpose: To check the local storage and verify if user is loading for the first time or no
*/

let checkLocalStorageRef = document.getElementById("checkLocalStorage");
let stringA = "First time user";
let stringB = "Old user";

let getLocalStorage = getData(APP_DATA_KEY);

// If there is data existing in local storage
if (getLocalStorage._currentBooking != "" || getLocalStorage._pastBooking != "" || getLocalStorage._futureBooking != "") {
    // Old user
    checkLocalStorageRef.innerHTML = stringB;
}
else {
    // New user
    checkLocalStorageRef.innerHTML = stringA;
}