import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["weather"]

  connect() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(position => {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;
        const apiKey = '1d90227e62a200f2482c263a608f79e6'; // Replace with your API key

        const urlWeather = `https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&units=metric&appid=${apiKey}`;

        fetch(urlWeather)
          .then(response => response.json())
          .then(data => {
            console.log(data);
            // TODO: Insert the weather info in the DOM (description, date, temperature...)
            this.weatherTarget.innerHTML = `
              <p class=''> ${data.name} <br>
              temp: ${data.main.temp} degrees</p>
            `;
          })
          .catch(error => {
            console.error('Error fetching weather data:', error);
          });
      }, error => {
        console.error('Error getting user location:', error);
      });
    } else {
      console.error('Geolocation is not supported by this browser.');
    }
  }
}




    // city.innerText = data2.name;
    // date.innerText = new Date().toISOString();
    // description.innerText = data2.weather[0].description;
    // temperature.innerText = `${data2.main.temp} degrees Celsius`;
