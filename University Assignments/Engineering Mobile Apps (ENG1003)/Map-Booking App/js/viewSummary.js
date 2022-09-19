"use strict";

/*
* Authors:  1. Hor Zu Hui  
*           2. Zareh Kozanian
*           3. Chia Zer
*           4. LAHIRU HASARANGA WELIWITIYA
* University: Monash University Malaysia
* Degree: E3001 Bachelor of Engineering (Honours) 
* Last modified: 21 May 2021
* Purpose: Contain the code required to show all the details 
*          of booking and it is needed to run viewSummary.html
*/

// Mapbox token, OpenCage API URL and key
const MAPBOX_TOKEN = "pk.eyJ1IjoiemFyZWgiLCJhIjoiY2tvbnlhcmI2MDViMTJvbWxyZGVuc2lzcyJ9.rtiO3k8izuydL2cClj05hA";
const OPENCAGE_API_KEY = "fea5fedb5f7d4dce9c025c8b6f4336de";
const OPENCAGE_URL = "https://api.opencagedata.com/geocode/v1/json";

// Setting up a new map
mapboxgl.accessToken = MAPBOX_TOKEN;
let map = new mapboxgl.Map({
   container: 'map',
   center: [101.6080, 3.0730],
   zoom: 16,
   style: 'mapbox://styles/mapbox/streets-v9'
});

// Initializing the required variables
let tempBookingId;
let tempBooking = new Booking();
let markerCoordinates = [];

// Create a taxi list
let taxiList;

// Create variables to store index
let listIndex;
let bookingIndex;

// Retrieve taxi list from local storage if exists
if (checkData(TAXI_LIST_KEY)) {
   taxiList = getData(TAXI_LIST_KEY);
}
// Create a new booking class and retrieve a new taxi lists
else {
   let taxiBooking = new Booking();
   taxiList = taxiBooking.taxi;
}

// If the user comes from viewBooking.html
if (checkData(TEMP_BOOKING_INDEX_KEY) == true) {
   // Retrieve the index
   let tempBookingIndex = getData(TEMP_BOOKING_INDEX_KEY);
   listIndex = tempBookingIndex[0];
   bookingIndex = tempBookingIndex[1];

   // Set the variables in tempBooking
   if (listIndex == 1) {
      tempBooking = (bookingApp._futureBooking[bookingIndex]);

      // Add the inputs to change taxi
      showTaxiInput();
   }
   else if (listIndex == 2) {
      tempBooking = (bookingApp._currentBooking[bookingIndex]);
   }
   else if (listIndex == 3) {
      tempBooking = (bookingApp._pastBooking[bookingIndex]);
   }

   // Get the reference variable from viewSummary.html
   let bookingIdRef = document.getElementById("bookingId");
   let pickUpAddressRef = document.getElementById("pickUpAddress");
   let dropOffAddressesRef = document.getElementById("dropOffAddresses");
   let dateRef = document.getElementById("date");
   let timeRef = document.getElementById("time");
   let noOfStopsRef = document.getElementById("noOfStops");
   let distanceRef = document.getElementById("distance")
   let fareRef = document.getElementById("fare");
   let taxiTypeRef = document.getElementById("taxiType");

   // Use .innerHTML() to show the data required in viewBooking.html
   bookingIdRef.innerHTML = tempBooking._bookingId;
   pickUpAddressRef.innerHTML = tempBooking._pickUpAddress;
   dropOffAddressesRef.innerHTML = tempBooking._dropOffAddresses;
   dateRef.innerHTML = tempBooking._date;
   timeRef.innerHTML = tempBooking._time;
   noOfStopsRef.innerHTML = tempBooking._numberOfStops;
   distanceRef.innerHTML = tempBooking._distance;
   fareRef.innerHTML = tempBooking._fare;
   if (tempBooking._taxiType == "Car") {
      taxiTypeRef.innerHTML = "Sedan";
   }
   else {
      taxiTypeRef.innerHTML = tempBooking._taxiType;
   }
   
   // Get the marker coordinates
   markerCoordinates = tempBooking._markerCoordinates;

   // Set up marker, line on the map and readjust the map after half second for map to load
   let timeoutMS = 500;
   setTimeout(setUpMarker, timeoutMS);
   setTimeout(setUpLine, timeoutMS);
   setTimeout(correctMap, timeoutMS);

   // Remove the index from local storage
   localStorage.removeItem(TEMP_BOOKING_INDEX_KEY);
}
// If the user comes from mapPage.html
else if (checkData(TEMPORARY_BOOKING_KEY) == true) {
   // Get the booking data needed from local storage
   tempBooking = getData(TEMPORARY_BOOKING_KEY);

   // Get the marker coordinates
   markerCoordinates = tempBooking._markerCoordinates;

   // Set up marker, line on the map and readjust the map after half second for map to load
   let timeoutMS = 500;
   setTimeout(setUpMarker, timeoutMS);
   setTimeout(setUpLine, timeoutMS);
   setTimeout(correctMap, timeoutMS);

   // Get the reference variable from viewSummary.html
   let bookingIdRef = document.getElementById("bookingId");
   let pickUpAddressRef = document.getElementById("pickUpAddress");
   let dropOffAddressesRef = document.getElementById("dropOffAddresses");
   let dateRef = document.getElementById("date");
   let timeRef = document.getElementById("time");
   let noOfStopsRef = document.getElementById("noOfStops");
   let distanceRef = document.getElementById("distance");
   let fareRef = document.getElementById("fare");
   let taxiTypeRef = document.getElementById("taxiType");

   // Use .innerHTML() to show the data required in viewBooking.html
   bookingIdRef.innerHTML = tempBooking._bookingId;
   pickUpAddressRef.innerHTML = tempBooking._pickUpAddress;
   dropOffAddressesRef.innerHTML = tempBooking._dropOffAddresses;
   dateRef.innerHTML = tempBooking._date;
   timeRef.innerHTML = tempBooking._time;
   noOfStopsRef.innerHTML = tempBooking._numberOfStops;
   distanceRef.innerHTML = tempBooking._distance;
   fareRef.innerHTML = tempBooking._fare;
   taxiTypeRef.innerHTML = tempBooking._taxiType;

   // Push it to future booking first
   bookingApp.addfutureBookings(tempBooking);

   // If it turns out to be less than 24 hours away
   bookingApp.updateCurrentBooking();

   // Store in local storage
   storeInLocalStorage(APP_DATA_KEY, bookingApp);

   // Remove the temporary booking in local storage
   localStorage.removeItem(TEMPORARY_BOOKING_KEY);
};

/*
* Function Name: setUpLine()
* 
* Purpose: Set up line between coordinates
*/
function setUpLine() {
   // Initialize the object
   let object = {
      type: "geojson",
      data: {
         type: "Feature",
         properties: {},
         geometry: {
            type: "LineString",
            coordinates: []
         }
      }
   };

   // Load in the coordinates
   for (let i = 0; i < markerCoordinates.length; i++) {
      object.data.geometry.coordinates.push(markerCoordinates[i]);
   }

   // Add line on the map
   map.addLayer({
      id: "routes",
      type: "line",
      source: object,
      layout: { "line-join": "round", "line-cap": "round" },
      paint: { "line-color": "#888", "line-width": 6 }
   });
};

/*
* Function Name: setUpMarker()
* 
* Purpose: Create a marker with the location set to the pick up coordinates
*/
function setUpMarker() {
   // Create a marker with the location set to the pick up coordinates
   let marker = new mapboxgl.Marker()
      .setLngLat(markerCoordinates[0])
      .setPopup(new mapboxgl.Popup().setHTML(`<p>${tempBooking._pickUpAddress}</p>`))
      .addTo(map);

   for (let i = 1; i < markerCoordinates.length; i++) {
      // Create a marker with the location set to the drop off coordinates
      let marker = new mapboxgl.Marker()
         .setLngLat(markerCoordinates[i])
         .setPopup(new mapboxgl.Popup().setHTML(`<p>${tempBooking._dropOffAddresses[i - 1]}</p>`))
         .addTo(map);
   }
};

/*
* Function Name: correctMap()
* 
* Purpose: Center and adjust the map zoom for the user
*/
function correctMap() {
   map.setCenter(markerCoordinates[0]);
   map.setZoom(12);
};

/*
* Function Name: showTaxiInput()
* 
* Purpose: Show the taxi type input to the user to change the taxi type
*/
function showTaxiInput() {
   let newTaxiInputRef = document.getElementById("newTaxiInput");
   let code = `<p>Prices subject to change according to taxi type.</p>
   <label for="newTaxi">Select a new taxi: </label>
   <select id="newTaxi">
       <option value="Car">Sedan</option>
       <option value="Minibus">Minibus</option>
       <option value="Van">Van</option>
       <option value="SUV">SUV</option>
   </select>
   <hr class="invisible_tags">
   <div id="taxiChangeAlert"></div>
   <div class="centered">
        <button style="background-color: rgb(43, 168, 5);" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent"
           onclick="changeTaxi()">
           Confirm Taxi Change
       </button>
   </div>
   <hr>`;
   newTaxiInputRef.innerHTML = code;
};

/*
 * Function Name: function calculateFare()
 * 
 * Purpose: Calculate fare for bookings
 */
function calculateFare() {
   // Base fare
   let totalFare = 3;

   // Convert the distance to meters
   let distance = tempBooking._distance * 1000;

   // Add distance based fare rate
   totalFare += (distance / 115 * 0.1)

   // Only future booking is able to change taxi and adjust the fare
   totalFare += 2;

   // Determine the type of taxi type
   if (tempBooking._taxiType == "SUV") {
       // Add RM 5 to total fare
       totalFare += 5;
   }
   else if (tempBooking._taxiType == "Van") {
      // Add RM 10 to total fare
      totalFare += 10;
   }
   else if (tempBooking._taxiType == "Minibus") {
       // Add RM 15 to total fare
       totalFare += 15;
   }

   // Determine if it is between 00:00 to 06:00
   if ((tempBooking._time > "00:00") && (tempBooking._time < "06:00")) {
      totalFare *= 1.5;
   }

   // Return the total fare in 2 decimal places
   return totalFare.toFixed(2);
};

/*
 * Function Name: function changeTaxi()
 * 
 * Purpose: Change the taxi type of a booking and updates the fare and also local storage
 */
function changeTaxi() {
   // Set it as the new taxi type
   let newTaxiRef = document.getElementById("newTaxi");
   let errorMsgRef = document.getElementById("taxiChangeAlert");

   for (let i = 0; i < taxiList.length; i++) {
      // Check for the availability of the taxi type
      if (newTaxiRef.value == taxiList[i].type) {
         if (taxiList[i].available == true) {
            // Set it in tempBooking and the availability as false
            tempBooking._taxiType = newTaxiRef.value;;
            taxiList[i].available = false;
            storeInLocalStorage(TAXI_LIST_KEY, taxiList);

            // Show an alert with a message indicating success
            showPostAlert(errorMsgRef, "Taxi type updated successfully!", colors.green, icons.tick);

            // Calculate the corresponding fare
            tempBooking._fare = calculateFare();

            // Show the new taxi type and fare
            let fareRef = document.getElementById("fare");
            let taxiTypeRef = document.getElementById("taxiType");
            fareRef.innerHTML = tempBooking._fare;
            taxiTypeRef.innerHTML = tempBooking._taxiType;

            // Change the future booking in app and store in local storage
            bookingApp._futureBooking[bookingIndex] = tempBooking;
            storeInLocalStorage(APP_DATA_KEY, bookingApp);

            // Terminate the function
            return;
         }
      }
   }

   // If the function did not terminate in the for loop
   showPostAlert(errorMsgRef, `Sorry, there are no available ${newTaxiRef.value}s at this moment!`, colors.red, icons.warning);
   return;
};

/*
 * Function Name: directViewBookingPage()
 * 
 * Purpose: This function is used to direct the user to viewBooking.html
 */
function directViewBookingPage() {
   window.location = "viewBooking.html";
}
