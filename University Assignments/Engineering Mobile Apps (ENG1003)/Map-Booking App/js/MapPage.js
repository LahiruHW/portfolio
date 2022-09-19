"use strict";

/*
* Authors:  1. Hor Zu Hui
*           2. Zareh Kozanian
*           3. Chia Zer
*           4. Lahiru Hasaranga Weliwitiya
* University: Monash University Malaysia
* Degree: E3001 Bachelor of Engineering (Honours) 
* Last modified: 21 May 2021
* Purpose: To perform the MapBox API and Geocoding coding required in MapPage.html
*          and contains all the coding required ot perform the booking
*/


// Mapbox token, OpenCage API URL and key
const MAPBOX_TOKEN = "pk.eyJ1IjoiemFyZWgiLCJhIjoiY2tvbnlhcmI2MDViMTJvbWxyZGVuc2lzcyJ9.rtiO3k8izuydL2cClj05hA";
const OPENCAGE_API_KEY = "fea5fedb5f7d4dce9c025c8b6f4336de";
const OPENCAGE_URL = "https://api.opencagedata.com/geocode/v1/json";

// Initializing the current drop Points
let currentDropPoints = [];

// Initializing the number of drop off addresess
let numberOfDropOffAddressesInput = 1;

// Initializing the array to store marker coordinates
let markerCoordinates = [[]];

// Create a new booking class upon entering mapPage.html
let newBooking = new Booking();

// Check if input are input correctly
let dateAndTimeCheck = false;
let pickUpCheck = false;
let dropOffCheck = false;
let taxiCheck = false;

// Create a taxi list
let taxiList;

if (checkData(TAXI_LIST_KEY)) {
    taxiList = getData(TAXI_LIST_KEY);
}
else {
    let taxiBooking = new Booking();
    taxiList = taxiBooking.taxi;
}

// Setting up a new map
mapboxgl.accessToken = MAPBOX_TOKEN;
let map = new mapboxgl.Map({
    container: 'map',
    center: [101.6080, 3.0730],
    zoom: 16,
    style: 'mapbox://styles/mapbox/streets-v9'
});

// Add geolocate control to the map
map.addControl(
    new mapboxgl.GeolocateControl({
        positionOptions: {
            enableHighAccuracy: true
        },
        trackUserLocation: true
    })
);

/*
 * Function Name: webServiceRequest()
 * 
 * Purpose: Do a web request
 * 
 * Argument: url        : The url needed
 * Argument: parameters : Parameters object
 */
function webServiceRequest(url, parameters) {
    // Build URL parameters from parameters object
    let params = "";
    // For each key in parameters object...
    for (let key in parameters) {
        if (parameters.hasOwnProperty(key)) {
            if (params.length == 0) {
                // First parameter starts with '?'
                params += "?";
            }
            else {
                // Subsequent parameter separated by '&'
                params += "&";
            }

            let encodedKey = encodeURIComponent(key);
            let encodedValue = encodeURIComponent(parameters[key]);
            params += encodedKey + "=" + encodedValue;
        }
    }
    let script = document.createElement('script');
    script.src = url + params;
    document.body.appendChild(script);
};

/*
 * Function Name: updateLocation()
 * 
 * Purpose: Reverse geocoding to get the latitude and longitude
 * 
 * Argument: latitude  : The latitude of the chosen address
 * Argument: longitude : The longitude of the chosen address
 */
function updateLocation(latitude, longitude) {
    let data = {
        q: `${latitude},${longitude}`,
        key: OPENCAGE_API_KEY,
        countrycode: `my`,
        jsonp: `showOnMap`
    }
    webServiceRequest(OPENCAGE_URL, data);
};

/*
 * Function Name: getPickUpAddress()
 * 
 * Purpose: This function is used to retrieve and store the pick-up address,
 *          as well as create the marker for the pick-up address
 */
function getPickUpAddress() {
    // Get the pick up address from the input
    let pickUpAddressRef = document.getElementById("pickUpAddress");
    let pickUpAddress = pickUpAddressRef.value;

    // Reference to error alert div container
    let errorMsgRef = document.getElementById("pickUpAddressError");

    if (pickUpAddress !== "") {
        // The paramters needed when making a web service request from OPENCAGE
        let parameters = {
            q: pickUpAddress,
            key: OPENCAGE_API_KEY,
            countrycode: "MY",
            jsonp: "showOnMap"
        }

        // Do a web serivce request
        webServiceRequest(OPENCAGE_URL, parameters);

        // Get the pick up address coordinates
        getPickUpCoords(pickUpAddress);

        // Successful alert message shown if all drop-off points successfully added
        showPostAlert(errorMsgRef, "Pick-up location confirmed!", colors.green, icons.tick);

        // Store it in the created booking object and into the local storage
        newBooking.pickUpAddress = pickUpAddress;
        storeInLocalStorage(TEMPORARY_BOOKING_KEY, newBooking);

        // Set the condition check as true
        pickUpCheck = true;
    }
    else {
        // Display an error dialogue for a short while and then make it dissappear.       
        showPostAlert(errorMsgRef, "Please enter a pick-up location", colors.red, icons.warning);
    }
};

/*
 * Function Name: getPickUpCoords()
 * 
 * Purpose: This function is used to get the pick-up coordinates
 * 
 * Argument: pickUpAddress : The pick-up addresses inputted by user
 */
function getPickUpCoords(pickUpAddress) {
    // The paramters needed when making a web service request from OPENCAGE
    let parameters = {
        q: pickUpAddress,
        key: OPENCAGE_API_KEY,
        countrycode: "MY",
        jsonp: "savePickUpCoords"
    }

    // Do a web serivce request
    webServiceRequest(OPENCAGE_URL, parameters);
};

/*
 * Function Name: savePickUpCoords()
 * 
 * Purpose: This function is used to save the pick-up coordinates
 * 
 * Argument: result : The returned result from OpenCage
 */
function savePickUpCoords(result) {
    let coordinates = [result.results[0].geometry.lng, result.results[0].geometry.lat];
    markerCoordinates[0] = coordinates;
    newBooking._markerCoordinates = markerCoordinates;
    storeInLocalStorage(TEMPORARY_BOOKING_KEY, newBooking);
};

/*
 * Function Name: getDropOffAddresses()
 * 
 * Purpose: This function is used to retrieve and store the drop off addresses,
 *          as well as create the markers for the drop off addresses
 */
function getDropOffAddresses() {
    // Pushing all the drop-points currently recorded into localStorage
    tempStoreDropOffPoints();

    // Reference div container that shows alert messages
    let errorMsgRef = document.getElementById("dropOffAddressesError");

    // Get the drop off address from the input
    let dropOffAddressesRef = document.getElementsByClassName("dropOffAddresses");

    // Store the drop off addresses as an temporary array first
    let dropOffAddresses = [];

    // Remove the existing drop off address coordinates
    if (markerCoordinates.length > 1) {
        let removeLength = markerCoordinates.length - 1;
        markerCoordinates.splice(1, removeLength);
    }

    for (let i = 0; i < dropOffAddressesRef.length; i++) {
        // Store it in the temporary array
        dropOffAddresses.push(dropOffAddressesRef[i].value);

        // Set it to a variable to make the web request
        let currentDropOffAddress = dropOffAddressesRef[i].value;

        // Make the web service request f the input is not blank
        if (currentDropOffAddress !== "") {
            // The paramters needed when making a web service request from OPENCAGE
            let parameters = {
                q: currentDropOffAddress,
                key: OPENCAGE_API_KEY,
                countrycode: "MY",
                jsonp: "showOnMap"
            }

            // Do a web service request
            webServiceRequest(OPENCAGE_URL, parameters);

            // Get the drop off address coordinates
            getDropOffCoords(currentDropOffAddress);
        }
        else {
            // Display an error dialogue for a short while and then make it dissappear         
            showPostAlert(errorMsgRef, `Drop off point ${i + 1} was left blank!`, colors.red, icons.warning);
            return;
        }
    }

    // Successful alert message shown if all drop-off points successfully added
    showPostAlert(errorMsgRef, "Drop-off points added!", colors.green, icons.tick);

    // Store it in the created booking object and into the local storage
    newBooking.dropOffAddresses = dropOffAddresses;
    storeInLocalStorage(TEMPORARY_BOOKING_KEY, newBooking);

    // Set the condition check as true
    dropOffCheck = true;
};

/*
 * Function Name: getDropOffCoords()
 * 
 * Purpose: This function is used to get the drop-off coordinates
 * 
 * Argument: dropOffAddress : The drop-off address inputted by user
 */
function getDropOffCoords(dropOffAddress) {
    // The paramters needed when making a web service request from OPENCAGE
    let parameters = {
        q: dropOffAddress,
        key: OPENCAGE_API_KEY,
        countrycode: "MY",
        jsonp: "saveDropOffCoords"
    }

    // Do a web serivce request
    webServiceRequest(OPENCAGE_URL, parameters);
};

/*
 * Function Name: saveDropOffCoords()
 * 
 * Purpose: This function is used to save the drop-off coordinates
 * 
 * Argument: result : The returned result from OpenCage
 */
function saveDropOffCoords(result) {
    let coordinates = [result.results[0].geometry.lng, result.results[0].geometry.lat];
    markerCoordinates.push(coordinates);
    newBooking._markerCoordinates = markerCoordinates;
    storeInLocalStorage(TEMPORARY_BOOKING_KEY, newBooking);
};

/* Function Name: showOnMap()
 * 
 * Purpose: This function is used to show the markers on the map
 * 
 * Argument: result : The returned result from OpenCage
 */
function showOnMap(result) {
    // Set the map to center at the marker   
    map.setCenter([result.results[0].geometry.lng, result.results[0].geometry.lat]);

    // Create a draggable marker with the location set to the city coordinates
    let marker = new mapboxgl.Marker({
        draggable: true
    })
        .setLngLat([result.results[0].geometry.lng, result.results[0].geometry.lat])
        .setPopup(new mapboxgl.Popup().setHTML(`<p>${result.results[0].formatted}</p>`))
        .addTo(map);

    // Function to move the pin and adjust the address
    function onDragFunc() {
        marker.remove();
        let lngLat = marker.getLngLat();
        console.log(lngLat)
        let longitude = lngLat.lng;
        let latitude = lngLat.lat;
        updateLocation(latitude, longitude)
        marker.togglePopup();
    }
    marker.on('dragend', onDragFunc)
};

/*
 * Function Name: addDropOffAddressesInput()
 * 
 * Purpose: This function is used to add inputs for drop off address
 */
function addDropOffAddressesInput() {
    tempStoreDropOffPoints();
    numberOfDropOffAddressesInput++;

    // added id to number of addresses input
    let dropOffAddressesInputRef = document.getElementById("dropOffAddressesInput");
    let htmlCode = `<hr> <div id='dropoff_${numberOfDropOffAddressesInput - 1}' class="mdl-grid">
    <div class="mdl-cell--4-col-phone">
        <label for="dropOffAddresses">Drop Off Address ${numberOfDropOffAddressesInput}: </label>
        <input class="dropOffAddresses" type="text"></input>
    </div>
    </div>`;
    dropOffAddressesInputRef.innerHTML += htmlCode;
    refreshDropOffPoints();     // to restore the previous locations
};

/*
 * Function Name: resetAddressInput()
 * 
 * Purpose: This function is used reset the address input and also remove all markers
 */
function resetAddressInput() {
    // Reset the pick up address input field
    let pickUpAddressInputRef = document.getElementById("pickUpAddressInput");
    let resetPickUpCode = `` +
        `<div class="mdl-grid">
        <!-- A <div> to display any error message -->
        <div class="mdl-textfield__error" id="pickUpAddressError"></div>
        <div class="mdl-cell--4-col-phone">
            <label for="pickUpAddress">Pick Up Address: </label>
            <input id="pickUpAddress" type="text"></input>
        </div>
    </div>`;

    pickUpAddressInputRef.innerHTML = resetPickUpCode;

    // Reset the drop off address input field
    numberOfDropOffAddressesInput = 1;
    let dropOffAddressesInputRef = document.getElementById("dropOffAddressesInput");
    let resetDropOffCode = `` +
        `<div id="dropoff_0" class="mdl-grid">
        <!-- A <div> to display any error message -->
        <div class="mdl-cell--4-col-phone mdl-cell mdl-cell--12-col" id="dropOffAddressesError">
        </div>
        <!-- First row of drop off address input -->
        <div class="mdl-cell--4-col-phone">
            <label for="dropOffAddresses">Drop Off Address: </label>
            <input class="dropOffAddresses" type="text"></input>
        </div>
    </div>`;

    dropOffAddressesInputRef.innerHTML = resetDropOffCode;

    // Removing all the input address data from local storage
    newBooking = JSON.parse(localStorage.getItem(TEMPORARY_BOOKING_KEY));
    newBooking.pickUpAddress = null;
    newBooking.dropOffAddresses = [];
    localStorage.setItem(TEMPORARY_BOOKING_KEY, JSON.stringify(newBooking));

    // Get the MapBox Container
    let mapboxContainer = document.getElementsByClassName("mapboxgl-canvas-container")[0];

    // Remove all of the markers from the map except for the map itself (map has index of 0)
    while (mapboxContainer.childNodes.length != 1) {
        mapboxContainer.removeChild(mapboxContainer.lastChild);
    }

    // Remove all of the coordinates in the array
    markerCoordinates = [];
};

/*
 * Function Name: saveDateAndTime()
 * 
 * Purpose: This function is used to save date and time in local storage
 * 
 * Returns: Show whether date and time is added successfully or not
 *          or if the previously selected date & time was updated
 */
function saveDateAndTime() {
    let dateObject = new Date();
    let todayDateTime = dateObject.toLocaleString();
    let outputStr = ""; // The initial state of date/time data

    let dateInputRef = document.getElementById("calendar");
    let timeInputRef = document.getElementById("time");
    let errorMsgRef = document.getElementById("date&timeError");

    let dateRef = dateInputRef.value; // Date
    let time = timeInputRef.value;   // Pickup Time
    let todayDateInput = new Date(`${dateRef} ${time}`);

    // Checks if the date and time in newBooking was initially empty
    // before clicking "CONFIRM DATE AND TIME" button
    if (newBooking.date === undefined && newBooking.time === undefined) {
        outputStr = "Date and time confirmed!";
    } else {
        outputStr = "Date and time updated!";
    }

    // Validate the input and show corresponding error messages
    if (dateRef !== "" && time !== "") {
        if (Date.parse(todayDateTime) < Date.parse(todayDateInput)) {
            newBooking.date = dateRef;
            newBooking.time = time;
            storeInLocalStorage(TEMPORARY_BOOKING_KEY, newBooking);
            showPostAlert(errorMsgRef, outputStr, colors.green, icons.tick);
            dateAndTimeCheck = true;
            return;
        }
        else {
            showPostAlert(errorMsgRef, "You can't book on date and time that has passed.", colors.red, icons.warning);
            return;
        }
    }
    else if (dateRef !== "" && time === "") {
        showPostAlert(errorMsgRef, "Please choose a time", colors.red, icons.warning);
        return;
    }
    else if (dateRef === "" && time !== "") {
        showPostAlert(errorMsgRef, "Please select a date", colors.red, icons.warning);
        return;
    }
    else if (dateRef === "" && time === "") {
        showPostAlert(errorMsgRef, "Date and time cannot be empty!", colors.red, icons.warning);
        return;
    }
};

/*
 * Function Name: saveTaxiType()
 * 
 * Purpose: This function is used to save taxi type
 */
function saveTaxiType() {
    // Reference of the div container containing the error alert
    let taxiTypeRef = document.getElementById("taxiType");
    let errorMsgRef = document.getElementById("taxiTypeError");

    // Retrieve the value from the input
    let taxiTypeIpt = taxiTypeRef.value;

    for (let i = 0; i < taxiList.length; i++) {
        if (taxiTypeIpt == taxiList[i].type) {
            // Check for the availability of the taxi type
            if (taxiList[i].available == true) {
                // Set it in tempBooking and the availability as false
                newBooking.taxiType = taxiTypeIpt;
                taxiList[i].available = false;
                storeInLocalStorage(TEMPORARY_BOOKING_KEY, newBooking);
                storeInLocalStorage(TAXI_LIST_KEY, taxiList)

                // Show an alert with a message indicating success
                showPostAlert(errorMsgRef, "Selected Taxi type added!", colors.green, icons.tick);
                taxiCheck = true;
                return;
            }
        }
    }

    // If the function did not terminate in the for loop
    showPostAlert(errorMsgRef, `There are no ${taxiTypeRef.value.toLowerCase()} taxis available at this moment`, colors.red, icons.warning);
}

/*
* Function Name: calculateDistance()
* 
* Purpose: Calculate Distance between the pick-up address and the drop-off addresses
*/
function calculateDistance() {
    // Initialise total distance as 0
    let totalDistance = 0;

    // Initialise the constants
    // Radius of Earth in kilometers
    let radiusOfEarth = 6371;

    for (let index = 1; index < markerCoordinates.length; index++) {
        // Longitude and latitude of the coordinates
        let longitude1 = markerCoordinates[index - 1][0] * Math.PI / 180; // Convert to radians
        let latitude1 = markerCoordinates[index - 1][1] * Math.PI / 180;
        let longitude2 = markerCoordinates[index][0] * Math.PI / 180;
        let latitude2 = markerCoordinates[index][1] * Math.PI / 180;

        // Difference in longitude and latitude of two coordinates
        let longitudeDiff = longitude2 - longitude1;
        let latitudeDiff = latitude2 - latitude1;

        let a = Math.sin(latitudeDiff / 2) * Math.sin(latitudeDiff / 2) +
            Math.cos(latitude1) * Math.cos(latitude2) *
            Math.sin(longitudeDiff / 2) * Math.sin(longitudeDiff / 2);
        let c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

        totalDistance += (radiusOfEarth * c);
    }

    // Return the total distance in 3 decimal places
    return totalDistance.toFixed(3);
};

/*
 * Function Name: function calculateFare()
 * 
 * Purpose: Calculate fare for the booking
 */
function calculateFare() {
    // Base fare
    let totalFare = 3;

    // Convert the distance to meters
    let distance = newBooking.distance * 1000;

    // Add distance based fare rate
    totalFare += (distance / 115 * 0.1)

    // Determine if it is a future booking
    let dayInMilliseconds = 24 * 60 * 60 * 1000;
    let currentDate = new Date().toLocaleDateString();
    if ((Date.parse(new Date(newBooking.date)) - Date.parse(currentDate)) <= dayInMilliseconds) {
        // Additional charge of RM 2 for future booking
        totalFare += 2;
    }

    // Determine the type of taxi type
    if (newBooking.taxiType == "SUV") {
        // Add RM 5 to total fare
        totalFare += 5;
    }
    else if (newBooking.taxiType == "Van") {
        // Add RM 10 to total fare
        totalFare += 10;
    }
    else if (newBooking.taxiType == "Minibus") {
        // Add RM 15 to total fare
        totalFare += 15;
    }

    // Determine if it is between 00:00 to 06:00
    if ((newBooking._time > "00:00") && (newBooking._time < "06:00")) {
        totalFare *= 1.5;
    }

    // Return the total fare in 2 decimal places
    return totalFare.toFixed(2);
};

/*
 * Function Name: goToViewSummary()
 * 
 * Purpose: This function is used to go to viewSummary.html
 */
function goToViewSummary() {
    // Store booking's distance, fare before the user goes to viewSummary.html
    newBooking.distance = calculateDistance();
    newBooking.fare = calculateFare();
    storeInLocalStorage(TEMPORARY_BOOKING_KEY, newBooking);

    // Validation and show corresponding error messages
    let errorMsgRef = document.getElementById("doneError");
    let message = "Required details: \n";
    if (dateAndTimeCheck && pickUpCheck && dropOffCheck && taxiCheck) {
        console.log("All confirmed data is valid, and stored in localStorage!!");
        showDialog();
    }
    else {
        if (!dateAndTimeCheck) {
            message += "date/time, ";
        }
        if (!pickUpCheck) {
            message += "pickup location, ";
        }
        if (!dropOffCheck) {
            message += "drop-off location/s, ";
        }
        if (!taxiCheck) {
            message += "taxi type ";
        }
        message += "\nare missing!";
        showPostAlert(errorMsgRef, message, colors.red, icons.warning);
        return;
    }
};

/*
 * Function Name: tempStoreDropOffPoints()
 * 
 * Purpose: This function is used to temporarily store drop-off points. Used when 
 *          updating the UI in any way.
 */
function tempStoreDropOffPoints() {
    // Used to update the number of stops in localStorage
    let stops = 0;

    // Temporarily stores the drop off points currently entered in the boxes 
    let dropOffAddressesRef = document.getElementsByClassName("dropOffAddresses");

    console.log("number of drop-offs" + dropOffAddressesRef.length);

    for (let i = 0; i < dropOffAddressesRef.length; i++) {
        if (dropOffAddressesRef[i].value === "") {
            currentDropPoints[i] = "";
        }
        else {
            currentDropPoints[i] = dropOffAddressesRef[i].value;
            stops++;
        }
    }
    newBooking.dropOffAddresses = currentDropPoints;
    newBooking.numberOfStops = stops;
    storeInLocalStorage(TEMPORARY_BOOKING_KEY, newBooking);
};

/*
 * Function Name: refreshDropOffPoints()
 * 
 * Purpose: This function is used to refresh drop-off points by deleting the existing
 *          drop-off points
 */
function refreshDropOffPoints() {
    // Retrieives the data of currentDropPoints from local storage and restores
    // them back into the input fields everytime the page is refreshed (or a new
    // element is added dynamically)
    let tempBooking = getData(TEMPORARY_BOOKING_KEY);
    let currentDropPoints = tempBooking._dropOffAddresses;

    let dropOffAddressesRef = document.getElementsByClassName("dropOffAddresses");
    for (let i = 0; i < dropOffAddressesRef.length - 1; i++) {
        dropOffAddressesRef[i].value = currentDropPoints[i];
    }
};

/*
 * Function Name: showDialog()
 * 
 * Purpose: This function is used to show dialog to do a final confirmation with the
 *          user before going to viewSummary.html
 */
function showDialog() {

    let dialog = document.querySelector('dialog');

    dialog.showModal();

    dialog.querySelector('.go').addEventListener('click', function () {
        window.location = "viewSummary.html";
    });

    dialog.querySelector('.close').addEventListener('click', function () {
        dialog.close();
    });
};