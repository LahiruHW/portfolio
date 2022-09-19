"use strict";

/*
* Authors:  1. Hor Zu Hui 
*           2. Zareh Kozanian
*           3. Chia Zer
*           4. LAHIRU HASARANGA WELIWITIYA
* University: Monash University Malaysia
* Degree: E3001 Bachelor of Engineering (Honours) 
* Last modified: 21 May 2021
* Purpose: Contain the code required to show all the future booking, 
*          current booking, or past booking and it is needed to run Viewbooking.html
*/

/*
* Function Name: showFutureBooking()
* 
* Purpose: To show the booking in the future booking section
* 
* Arguments: data : Booking data
*/
function showFutureBooking(data) {
    let futureBookRef = document.getElementById("futureBooking");
    let futureCode = "";
    for (let i = data.length - 1; i >= 0; i--) {
        futureCode += `
        <div class="mdl-grid">
        <div class="mdl-cell--3-col-phone">
            <p>Booking Id: ${data[i]._bookingId}</p>
            <p>Time/Date: ${data[i]._date + " at " + data[i]._time}</p>
            <p>Pick Up Point: ${data[i]._pickUpAddress}</p>
            <p>Final Destination: ${data[i]._dropOffAddresses[data[i]._numberOfStops - 1]}</p>
            <p>Total Number of Stops: ${data[i]._numberOfStops}</p>
        </div>
        <div class="mdl-cell--1-col-phone">
            <p>Distance: ${data[i]._distance}km</p>
            <p>Fare: RM${data[i]._fare}</p>
            <div class="viewButton">
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" onclick="viewSummary(${1},${i})">
                    View
                </button>
            </div>
            <br>
            <div class="cancelButton">
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" onclick="cancelBooking(${i})">
                    Cancel
                </button>
            </div>
        </div>
        </div>`
    }
    futureBookRef.innerHTML = futureCode;
}

/*
* Function Name: showCurrentBooking()
* 
* Purpose: To show the booking in the current booking section
* 
* Arguments: data : Booking data
*/
function showCurrentBooking(data) {
    let currentBookRef = document.getElementById("currentBooking");
    let currentCode = "";
    for (let j = data.length - 1; j >= 0; j--) {
        currentCode += `
        <div class="mdl-grid">
        <div class="mdl-cell--3-col-phone">
            <p>Booking Id: ${data[j]._bookingId}</p>
            <p>Time/Date: ${data[j]._date + " at " + data[j]._time}</p>
            <p>Pick Up Point: ${data[j]._pickUpAddress}</p>
            <p>Final Destination: ${data[j]._dropOffAddresses[data[j]._numberOfStops - 1]}</p>
            <p>Total Number of Stops: ${data[j]._numberOfStops}</p>
        </div>
        <div class="mdl-cell--1-col-phone">
            <p>Distance: ${data[j]._distance}km</p>
            <p>Fare: RM${data[j]._fare}</p>
            <div class="viewButton">
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" onclick="viewSummary(${2},${j})">
                    View
                </button>
            </div>
        </div>
        </div>`
    }
    currentBookRef.innerHTML = currentCode;
}

/*
* Function Name: showPastBooking()
* 
* Purpose: To show the booking in the past booking section
* 
* Arguments: data : Booking data
*/
function showPastBooking(data) {
    let pastBookRef = document.getElementById("pastBooking");
    let pastCode = "";
    for (let k = data.length - 1; k >= 0; k--) {
        pastCode += `
        <div class="mdl-grid">
        <div class="mdl-cell--3-col-phone">
            <p>Booking Id: ${data[k]._bookingId}</p>
            <p>Time/Date: ${data[k]._date + " at " + data[k]._time}</p>
            <p>Pick Up Point: ${data[k]._pickUpAddress}</p>
            <p>Final Destination: ${data[k]._dropOffAddresses[data[k]._numberOfStops - 1]}</p>
            <p>Total Number of Stops: ${data[k]._numberOfStops}</p>
        </div>
        <div class="mdl-cell--1-col-phone">
            <p>Distance: ${data[k]._distance}km</p>
            <p>Fare: RM${data[k]._fare}</p>
            <div class="viewButton">
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" onclick="viewSummary(${3},${k})">
                    View
                </button>
            </div>
        </div>
        </div>`
    }
    pastBookRef.innerHTML = pastCode;
}

/*
* Function Name: cancelBooking()
* 
* Purpose: Cancel the booking and update it in local storage
* 
* Arguments: index : Booking index
*/
function cancelBooking(index) {
    bookingApp.cancelBooking(index);
    window.location = "viewBooking.html";
    storeInLocalStorage(APP_DATA_KEY, bookingApp);
    showFutureBooking(bookingApp);
}

/*
* Function Name: viewSummary()
* 
* Purpose: View the summary of booking performed
* 
* Arguments: booking : The corresponding list that the booking is in
* Arguments: index   : Booking index
*/
function viewSummary(booking, index) {
    storeInLocalStorage(TEMP_BOOKING_INDEX_KEY, [booking, index]);
    window.location = "viewSummary.html";
};

window.onload = function () {
    // Update the bookings in bookingApp and local storage
    bookingApp.updateCurrentBooking();
    bookingApp.updatePastBooking();
    storeInLocalStorage(APP_DATA_KEY, bookingApp);

    // Initializing required data
    let futureData = bookingApp._futureBooking;
    let currentData = bookingApp._currentBooking;
    let pastData = bookingApp._pastBooking;

    // Show the data on the page
    showFutureBooking(futureData);
    showCurrentBooking(currentData);
    showPastBooking(pastData);
}