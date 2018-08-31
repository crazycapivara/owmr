# owmr 0.3.0

* Added a `NEWS.md` file to track changes to the package.

# owmr 0.4.0

* Added function to search owm's city list by city name.
* Added tests for current data.
   - Added helper function to fetch 'fresh' data used in tests.

# owmr 0.4.1

* Added function to fetch current weather data for multiple cities at once.

# owmr 0.5.0

* Refactored code
* Added function to fetch current weather data for cities around geo point (more or less an alias to `find_city`).
* Marked UTF-8 string in data fixed.

# owmr 0.6.1

* Added function to show weather data on leaflet map.
  - Added operator `%$$%` to render template text for popups. 

# owmr 0.7.0

* Added functions to add owm tiles to leaflet map.
  - Note: Performance of owm tile server seems to be low.

# owmr 0.7.1

* Fixed false poitives in check for undefined global variable `.` from `magrittr`

# owmr 0.7.2

* Updated package description

# owmr 0.7.3

* Added feature to store the api key in an environment variable called `OWM_API_KEY`
  - even if it is still possible to set the key via `owmr_settings`, it is recommended that you use the environment variable instead
  
