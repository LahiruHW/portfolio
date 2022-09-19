"use strict";

/*
* Authors:  1. Hor Zu Hui  
*           2. Zareh Kozanian
*           3. Chia Zer
*           4. LAHIRU HASARANGA WELIWITIYA
* University: Monash University Malaysia
* Degree: E3001 Bachelor of Engineering (Honours) 
* Last modified: 21 May 2021
* Purpose: It will load on all pages and will contain definition for classes, as well as it will share
*          code that will be executed on all pages such as loading of data from local storage when page loads
*/

// The keys to access local storage
const APP_DATA_KEY = "appData";
const TEMP_BOOKING_INDEX_KEY = "tempBookingIndex";
const TEMPORARY_BOOKING_KEY = "tempBooking";
const TAXI_LIST_KEY = "taxiBooking";

// Data objects that store HTML codes for representing different colours and 
// icons used in various alert messages
let colors = {
    red: "#f44336",
    green: "#0bb619",
    blue: "#1454F6"
};

let icons = {
    warning: "&#9888",
    tick: "&#10003",
    cross: "&#10060"
};

// Class to that stores all of the different type of bookings
class App {
    // Constructor
    constructor() {
        this._pastBooking = [];
        this._currentBooking = [];
        this._futureBooking = [];
    }

    // Accessors
    get pastBooking() {
        return this._pastBooking;
    }

    get currentBooking() {
        return this._currentBooking;
    }

    get futureBooking() {
        return this._futureBooking;
    }

    // Methods
    // Add a booking to the future booking list
    addfutureBookings(booking) {
        this._futureBooking.push(booking)
    }

    // Cancel a future booking and remove it from the future booking list
    cancelBooking(index) {
        if (confirm("Press OK if you want to delete the booking") == true) {

            // make the taxi assigned to the booking available again
            let removedbooking = this._futureBooking[index];
            let taxis = getData(TAXI_LIST_KEY);

            for (let i = 0 ; i < taxis.length; i++){
                if (removedbooking._taxiType === taxis[i].type && 
                                                 taxis[i].available == false){
                    taxis[i].available = true;
                    storeInLocalStorage(TAXI_LIST_KEY, taxis);
                    break;
                }
            }

            this._futureBooking.splice(index, 1);

        }
        else {
            return;
        }
    }

    // View all of the bookings
    viewAllBooking() {
        let returnedBookings = [];

        for (let i = 0; i < this._pastBooking.length; i++) {
            returnedBookings.push(this._pastBooking[i]);
        }
        for (let j = 0; j < this._currentBooking.length; j++) {
            returnedBookings.push(this._currentBooking[j]);
        }
        for (let k = 0; k < this._futureBooking.length; k++) {
            returnedBookings.push(this._futureBooking[k]);
        }
        return returnedBookings;
    }

    // View all of the past bookings
    viewPastBooking() {
        let returnedBookings = [];
        for (let i = 0; i < this._pastBooking.length; i++) {
            returnedBookings.push(this._pastBooking[i]);
        }
        return returnedBookings;
    }

    // View all of the current bookings
    viewCurrentBooking() {
        let returnedBookings = [];
        for (let i = 0; i < this._currentBooking.length; i++) {
            returnedBookings.push(this._currentBooking[i]);
        }
        return returnedBookings;
    }

    // View all of the future bookings
    viewFutureBooking() {
        let returnedBookings = [];
        for (let i = 0; i < this._futureBooking.length; i++) {
            returnedBookings.push(this._futureBooking[i]);
        }
        return returnedBookings;
    }

    // Move the current booking to the past booking
    updatePastBooking() {
        for (let i = 0; i < this._currentBooking.length; i++) {
            let currentTime = new Date().toLocaleString();
            let currentBooking = this._currentBooking[i];
            let thisBookingDate = currentBooking._date;
            let thisBookingTime = currentBooking._time;
            let currentInputTime = new Date(`${thisBookingDate} ${thisBookingTime}`)

            // If the current time is have past the booking time, the booking is categorized as past
            if (Date.parse(currentTime) > Date.parse(currentInputTime))
            {
                let newPastBooking = new Booking();
                newPastBooking.bookingId = currentBooking._bookingId;
                newPastBooking.time = currentBooking._time;
                newPastBooking.date = currentBooking._date;
                newPastBooking.pickUpAddress = currentBooking._pickUpAddress;
                newPastBooking.dropOffAddresses = currentBooking._dropOffAddresses;
                newPastBooking.distance = currentBooking._distance;
                newPastBooking.fare = currentBooking._fare;
                newPastBooking.taxiType = currentBooking._taxiType;
                newPastBooking.markerCoordinates = currentBooking._markerCoordinates;
                newPastBooking.numberOfStops = currentBooking._numberOfStops;

                // Push the new booking data into past booking and remove it from current booking
                this._pastBooking.push(newPastBooking);
                this._currentBooking.splice(i, 1);
                i = -1;
            }
        }
    }

    // Move the future booking to the current booking
    updateCurrentBooking() {
        let dayInMilliseconds = 24 * 60 * 60 * 1000;

        for (let i = 0; i < this._futureBooking.length; i++) {
            let currentDate = new Date().toLocaleDateString();
            let futureBooking = this._futureBooking[i];
            let thisBookingDate = futureBooking._date
            let currentInputDate = new Date(thisBookingDate)

            // If the booking is less than 24 hours from now
            if ((Date.parse(currentInputDate) - Date.parse(currentDate)) <= dayInMilliseconds) {
                let newCurrentBooking = new Booking();
                newCurrentBooking.bookingId = futureBooking._bookingId;
                newCurrentBooking.time = futureBooking._time;
                newCurrentBooking.date = futureBooking._date;
                newCurrentBooking.pickUpAddress = futureBooking._pickUpAddress;
                newCurrentBooking.dropOffAddresses = futureBooking._dropOffAddresses;
                newCurrentBooking.distance = futureBooking._distance;
                newCurrentBooking.fare = futureBooking._fare;
                newCurrentBooking.taxiType = futureBooking._taxiType;
                newCurrentBooking.markerCoordinates = futureBooking._markerCoordinates;
                newCurrentBooking.numberOfStops = futureBooking._numberOfStops;

                // Push the new booking data into current booking and remove it from future booking
                this._currentBooking.push(newCurrentBooking);
                this._futureBooking.splice(i, 1);
                i = -1;
            }
        }
    }

    toString() {
        if (this._futureBooking.length == 0) {
            console.log("The future booking list is empty");
        }
        else {
            for (let i = 0; i < this._futureBooking.length; i++) {
                let output = `Booking Id: ${this._futureBooking[i].bookingId}\n 
                Date/Time: ${this._futureBooking[i].date} @ ${this._futureBooking[i].time}\n
                Pick Up Address: ${this._futureBooking[i].pickUpAddress}\n
                Drop Off Address: ${this._futureBooking[i].dropOffAddresses}\n
                Distance: ${this._futureBooking[i].distance}\n
                Fare: ${this._futureBooking[i].fare}\n
                Taxi Type: ${this._futureBooking[i].taxiType}`;
                console.log(output);
            }
        }

        if (this._currentBooking.length == 0) {
            console.log("The current booking list is empty");
        }
        else {
            for (let i = 0; i < this._currentBooking.length; i++) {
                let output = `Booking Id: ${this._currentBooking[i].bookingId}\n
                Date/Time: ${this._currentBooking[i].date} @ ${this._currentBooking[i].time}\n
                Pick Up Address: ${this._currentBooking[i].pickUpAddress}\n
                Drop Off Address: ${this._currentBooking[i].dropOffAddresses}\n
                Distance: ${this._currentBooking[i].distance}\n
                Fare: ${this._currentBooking[i].fare}\n
                Taxi Type: ${this._currentBooking[i].taxiType}`;
                console.log(output);
            }
        }

        if (this._pastBooking.length == 0) {
            console.log("The past booking list is empty");
        }
        else {
            for (let i = 0; i < this._pastBooking.length; i++) {
                let output = `Booking Id: ${this._pastBooking[i].bookingId}\n
                Date/Time: ${this._pastBooking[i].date} @ ${this._pastBooking[i].time}\n
                Pick Up Address: ${this._pastBooking[i].pickUpAddress}\n
                Drop Off Address: ${this._pastBooking[i].dropOffAddresses}\n
                Distance: ${this._pastBooking[i].distance}\n
                Fare: ${this._pastBooking[i].fare}\n
                Taxi Type: ${this._pastBooking[i].taxiType}`;
                console.log(output);
            }
        }
    }

    fromData(appDataObject) {
        this._pastBooking = appDataObject._pastBooking;
        this._currentBooking = appDataObject._currentBooking;
        this._futureBooking = appDataObject._futureBooking;
    }
}

// Class that stores all of the booking details
class Booking {
    // Constructor
    constructor() {
        this._bookingId = Math.random().toString(36).slice(2);
        this._time;
        this._date;
        this._pickUpAddress;
        this._dropOffAddresses = [];
        this._numberOfStops;
        this._distance;
        this._fare;
        this._taxiType = "sedan";
        this._markerCoordinates = [];
        this._taxi = [
            { "rego": "VOV-887", "type": "Car", "available": true },
            { "rego": "OZS-293", "type": "Van", "available": false },
            { "rego": "WRE-188", "type": "SUV", "available": true },
            { "rego": "FWZ-490", "type": "Car", "available": true },
            { "rego": "NYE-874", "type": "SUV", "available": true },
            { "rego": "TES-277", "type": "Car", "available": false },
            { "rego": "GSP-874", "type": "SUV", "available": false },
            { "rego": "UAH-328", "type": "Minibus", "available": true },
            { "rego": "RJQ-001", "type": "SUV", "available": false },
            { "rego": "AGD-793", "type": "Minibus", "available": false }
        ];
    }

    // Accessors
    get bookingId() {
        return this._bookingId;
    }

    get time() {
        return this._time;
    }

    get date() {
        return this._date;
    }

    get pickUpAddress() {
        return this._pickUpAddress;
    }

    get dropOffAddresses() {
        return this._dropOffAddresses;
    }

    get numberOfStops() {
        return this._numberOfStops;;
    }

    get distance() {
        return this._distance;
    }

    get fare() {
        return this._fare;
    }

    get taxiType() {
        return this._taxiType;
    }

    get markerCoordinates() {
        return this._markerCoordinates;
    }

    get taxi() {
        return this._taxi
    }

    // Mutators
    set bookingId(newBookingId) {
        this._bookingId = newBookingId;
    }
    set time(newTime) {
        this._time = newTime;
    }
    set date(newDate) {
        this._date = newDate;
    }

    set pickUpAddress(newPickUpAddress) {
        this._pickUpAddress = newPickUpAddress;
    }

    set dropOffAddresses(dropOffAddresses) {
        this._dropOffAddresses = dropOffAddresses;
    }
    set numberOfStops(numberOfStops) {
        this._numberOfStops = numberOfStops;
    }

    set distance(newDistance) {
        this._distance = newDistance;
    }

    set fare(newFare) {
        this._fare = newFare;
    }

    set taxiType(newTaxiType) {
        this._taxiType = newTaxiType;
    }

    set markerCoordinates(newMarkerCoordinates) {
        this._markerCoordinates = newMarkerCoordinates;
    }

    set taxi(newTaxi) {
        this._taxi = newTaxi;
    }

    // Methods
    toString() {
        let output = `Booking Id: ${this._bookingId}\n
        Date/Time: ${this._date} @ ${this._time}\n
        Pick Up Address: ${this._pickUpAddress}\n
        Drop Off Address: ${this._dropOffAddresses}\n
        Number of Stops: ${this._numberOfStops}\n
        Distance: ${this._distance}\n
        Fare: ${this._fare}\n
        Taxi Type: ${this._taxiType}\n
        Marker Coordinates: ${this._markerCoordinates}`;
        console.log(output);
    }

    fromData(bookingDataObject) {
        this._bookingId = bookingDataObject.bookingId;
        this._time = bookingDataObject.time;
        this._date = bookingDataObject.date;
        this._pickUpAddress = bookingDataObject.pickUpAddress;
        this._dropOffAddresses = bookingDataObject.dropOffAddresses;
        this._numberOfStops = bookingDataObject.numberOfStops;
        this._distance = bookingDataObject.distance;
        this._fare = bookingDataObject.fare;
        this._taxiType = bookingDataObject.taxiType;
        this._markerCoordinates = bookingDataObject.markerCoordinates;
    }

}

/*
 * Function Name : checkData()
 * 
 * Purpose: This function is used to check if any data is stored in localStorage at provided key
 * 
 * Argument: key : Provide key to where to check data
 * 
 * Returns: Whether there is data in the local storage or not
 */
function checkData(key) {
    let answer = false;
    if (localStorage.getItem(key) !== null) {
        answer = true;
    }
    return answer;
};

/*
 * Function Name: getData()
 * 
 * Purpose: This function is used to retrieve / get data from localStorage
 * 
 * Argument: key : Provide key where to get data
 * 
 * Returns: The retrieved data
 */
function getData(key) {
    let retrieveData = localStorage.getItem(key);
    try {
        retrieveData = JSON.parse(retrieveData);
    }
    catch (error) {
        console.log(error);
    }
    finally {
        return retrieveData;
    }
};

/*
 * Function Name: directMainPage()
 * 
 * Purpose: This function is used to direct user to other pages of html
 */
function directBookingPage() {
    window.location = "mapPage.html";
};

/*
* Function Name: storeInLocalStorage()
* 
* Purpose: To store current booking Class data in localStorage 
* 
* Arguments: appData : Contains current Booking class data (local variable)
* Arguments: key : Provide key store local storage
*/
function storeInLocalStorage(key, appData) {
    // storing booking data arrays to local storage
    localStorage.setItem(key, JSON.stringify(appData));
};

/*
 * Function Name: showPostAlert()
 * 
 * Purpose: This function is used to display the error message based on the parameters
 * 
 * Argument: errorMsgRef : The reference variable pointing to the respective div 
 *                         container that will hold the error message alert
 * Argument: thisMessage : The string message that will be displayed in the alert message
 * Argument: thisColor   : The colour that the alert must be, based off of the "colors"
 *                         data object.
 * Argument: thisIcon    : The icon that must be shown alongside the message in the alert,
 *                         based off of the "icons" data object.
 */
function showPostAlert(errorMsgRef, thisMessage, thisColor, thisIcon) {
    // Used to display the error message based on the parameters such as the
    // message, colour, icon and the reference varialbe of the respective
    // error message container.
    setTimeout(function () {
        errorMsgRef.innerHTML = `<hr>` +
            `<div class="alert" style="text-align: left; background-color: ${thisColor};"> 
            <span id="warning">${thisIcon};</span>
            <strong>${thisMessage}</strong>
        </div>
        <hr>`;
    }, 30)
    setTimeout(() => { errorMsgRef.innerHTML = ""; }, 3000);
};


// Create an instance of 'App' everytime when any page is loaded
let bookingApp = new App();

// If it is already exists in local storage
if (checkData(APP_DATA_KEY)) {
    let appData = getData(APP_DATA_KEY);
    bookingApp.fromData(appData);
}
else {
    // Store the newly created 'App' into local storage
    storeInLocalStorage(APP_DATA_KEY, bookingApp);
}