/**
  * This script builds the webpage based on existing events and measurements. 
  * For each event an HTML button is added (the event will be raised by 
  * clicking it). Measurements are represented by traffic lights (green means
  * ready, red not ready).
  **/

// URIs.
MEASUREMENTS_URI = "/measurements";
EVENTS_URI = "/events";

// Measurement status.
var MeasurementStatus = {"Green":0, "Yellow":1, "Red":2}

// Status codes.
var statusText = [];
statusText[0] = "Server Not Available";
statusText[100] = "Continue";
statusText[101] = "Switching Protocols";
statusText[102] = "Processing";
statusText[200] = "OK";
statusText[201] = "Created";
statusText[202] = "Accepted";
statusText[203] = "Non-Authoritative Information";
statusText[204] = "No Content";
statusText[205] = "Reset Content";
statusText[206] = "Partial Content";
statusText[207] = "Multi-Status";
statusText[300] = "Multiple Choices";
statusText[301] = "Moved Permanently";
statusText[302] = "Found";
statusText[303] = "See Other";
statusText[304] = "Not Modified";
statusText[305] = "Use Proxy";
statusText[306] = "Switch Proxy";
statusText[307] = "Temporary Redirect";
statusText[400] = "Bad Request";
statusText[401] = "Unauthorized";
statusText[402] = "Payment Required";
statusText[403] = "Forbidden";
statusText[404] = "Not Found";
statusText[405] = "Method Not Allowed";
statusText[406] = "Not Acceptable";
statusText[407] = "Proxy Authentication Required";
statusText[408] = "Request Timeout";
statusText[409] = "Conflict";
statusText[410] = "Gone";
statusText[411] = "Length Required";
statusText[412] = "Precondition Failed";
statusText[413] = "Request Entity Too Large";
statusText[414] = "Request-URI Too Long";
statusText[415] = "Unsupported Media Type";
statusText[416] = "Requested Range Not Satisfiable";
statusText[417] = "Expectation Failed";
statusText[418] = "I'm a teapot";
statusText[421] = "There are too many connections from your internet address";
statusText[422] = "Unprocessable Entity";
statusText[423] = "Locked";
statusText[424] = "Failed Dependency";
statusText[425] = "Unordered Collection";
statusText[426] = "Upgrade Required";
statusText[449] = "Retry With";
statusText[450] = "Blocked by Windows Parental Controls";
statusText[500] = "Internal Server Error";
statusText[501] = "Not Implemented";
statusText[502] = "Bad Gateway";
statusText[503] = "Service Unavailable";
statusText[504] = "Gateway Timeout";
statusText[505] = "HTTP Version Not Supported";
statusText[506] = "Variant Also Negotiates";
statusText[507] = "Insufficient Storage";
statusText[509] = "Bandwidth Limit Exceeded";
statusText[510] = "Not Extended";
statusText[530] = "User access denied";

// Return current time.
function formatCurrentTime() {
	var currentTime = new Date();
	var hours = currentTime.getHours();
	var minutes = currentTime.getMinutes();
	var seconds = currentTime.getSeconds();
	if (minutes < 10) {
		minutes = "0" + minutes;
	}
	if (seconds < 10) {
		seconds = "0" + seconds;
	}
	return hours + ":" + minutes + ":" + seconds;
}

// Insert after for DOM manipulations.
function insertAfter(newElement,targetElement) {
	var parent = targetElement.parentNode;
 	if (parent.lastchild == targetElement) {
		parent.appendChild(newElement);
	}
	else {
		parent.insertBefore(newElement, targetElement.nextSibling);
	}
}

// Show status message of the HTTP response.
function logResponse(response) {
	logMessage("“" + response.request.url + "” returned " + 
		statusText[response.status] + " (" + response.status + ").")
}

// Log message.
function logMessage(message) {
	var paragraph = document.createElement("p");
	var strong = document.createElement("strong");
	var timeTextNode = document.createTextNode(formatCurrentTime() + ": ");
	var contentTextNode = document.createTextNode(message);
	strong.appendChild(timeTextNode);
	paragraph.appendChild(strong);
	paragraph.appendChild(contentTextNode);
	
	// Show in error section.
	insertAfter(paragraph, $("log").firstChild.nextSibling);
	if ($("log").childNodes.length > 12) {
		$("log").removeChild($("log").lastChild)
	}
	$("log").show();
}

// Send event to server.
function sendEvent(uri) {
	new Ajax.Request(uri, {
		method:"post",
		requestHeaders: ["Accept", "application/json"],
		onSuccess: logResponse,
		onFailure: logResponse
	});
}

// Regularly update measurement status.
function registerForUri(uri, func) {
	new Ajax.Request(uri + "?waitForUpdate=yes", {
		method: 'get',
		requestHeaders: ["Accept", "application/json"],
		onSuccess: function(response) {			// Success callback.
			if (response.status != 0)
			{
				func(response);
				registerForUri(uri, func);
			}
			else
			{
				logResponse(response);
			}
		},
		onFailure: logResponse
	});
}

// Create traffic light and add it to the document.
function addTrafficLight(response) {
	var measurement = response.responseJSON;
	if (measurement != null && measurement.name != null
							&& measurement.values != null
							&& measurement.status != null
							&& measurement.uri != null) {
		// Create label.
		var label = document.createElement("span");
		var content = document.createTextNode(measurement.name + " (" + measurement.values + ")");
		var measurementNameId = measurement.name.replace(" ", "_") + "_values";
		label.setAttribute("id", measurementNameId);
		label.appendChild(content);
		
		// Create traffic light.
		var trafficLight = document.createElement("p");
		var trafficLightImage = document.createElement("img");
		var measurementId = measurement.name.replace(" ", "_");
		trafficLightImage.setAttribute("id", measurementId);
		if (measurement.status == MeasurementStatus.Green) {
			trafficLightImage.setAttribute("src", "green_light.png");
		}
		else if (measurement.status == MeasurementStatus.Yellow) {
			trafficLightImage.setAttribute("src", "yellow_light.png");
		}
		else {
			trafficLightImage.setAttribute("src", "red_light.png");
		}
		trafficLight.appendChild(trafficLightImage);
		
		// Create measurement.
		var measurementFigure = document.createElement("figure");
		measurementFigure.appendChild(trafficLight);
		measurementFigure.appendChild(label);
		
		// Add to measurement section.
		var figureArray = $("measurements").select("figure");
		var minimum = figureArray.find(function(element) {return element.textContent > measurement.name});
		if (minimum) {
			$("measurements").insertBefore(measurementFigure, minimum);
		}
		else {
			$("measurements").appendChild(measurementFigure);
		}
		
		// Register for changes.
		registerForUri(measurement.uri, updateTrafficLight);
	}
}

// Update traffic light.
function updateTrafficLight(response) {
	var measurement = response.responseJSON;
	if (measurement != null && measurement.name != null
							&& measurement.values != null
							&& measurement.status != null) {
		var content = document.createTextNode(measurement.name + " (" + measurement.values + ")");
		var measurementNameId = measurement.name.replace(" ", "_") + "_values";
		$(measurementNameId).replaceChild(content, $(measurementNameId).firstChild);
		
		var measurementId = measurement.name.replace(" ", "_");
		if (measurement.status == MeasurementStatus.Green) {
			$(measurementId).setAttribute("src", "green_light.png");
		}
		else if (measurement.status == MeasurementStatus.Yellow) {
			$(measurementId).setAttribute("src", "yellow_light.png");
		}
		else {
			$(measurementId).setAttribute("src", "red_light.png");
		}
	}
}

// Create event button and add it to the document.
function addEventButton(response) {
	var event = response.responseJSON;
	if (event != null && event.name != null && event.uri != null) {
		// Create label.
		var eventButton = document.createElement("button");
		eventButton.setAttribute("type", "submit");
		var content = document.createTextNode(event.name);
		eventButton.appendChild(content);
		
		// Create event button.
		var eventForm = document.createElement("form");
		var eventId = event.name.replace(" ", "_");
		eventForm.setAttribute("id", eventId);
		eventForm.setAttribute("method", "POST");
		eventForm.setAttribute("action", "javascript:sendEvent(\"" + 
			event.uri + "\")");
		eventForm.appendChild(eventButton);
		
		// Add to events section.
		var formArray = $("events").select("form");
		var minimum = formArray.find(function(element) {return element.textContent > event.name});
		if (minimum) {
			$("events").insertBefore(eventForm, minimum);
		}
		else {
			$("events").appendChild(eventForm);
		}
	}
}

// Request all available measurements and add traffic lights based on current 
// status.
new Ajax.Request(MEASUREMENTS_URI, {
	method:"get",										// Use HTTP get method.
	requestHeaders: ["Accept", "application/json"],		// Request JSON.
	onSuccess: function(response) {						// Success callback.
		if (response.responseJSON != null &&
			response.responseJSON.measurements != null) {
			// Request each measurement.
			response.responseJSON.measurements.each(function(uri) {
				new Ajax.Request(uri, {
					method:"get",
					requestHeaders: ["Accept", "application/json"],
					onSuccess: addTrafficLight,
					onFailure: logResponse
				});
			});
		}
	},
	onFailure: logResponse						// Failure callback.
});

// Request all available events and add buttons to the document.
new Ajax.Request(EVENTS_URI, {
	method:"get",										// Use HTTP get method.
	requestHeaders: ["Accept", "application/json"],		// Request JSON.
	onSuccess: function(response) {						// Success callback.
		if (response.responseJSON != null &&
			response.responseJSON.events != null) {
			// Request each event.
			response.responseJSON.events.each(function(uri) {
				new Ajax.Request(uri, {
					method:"get",
					requestHeaders: ["Accept", "application/json"],
					onSuccess: addEventButton,
					onFailure: logResponse
				});
			});
		}
	},
	onFailure: logResponse						// Failure callback.
});