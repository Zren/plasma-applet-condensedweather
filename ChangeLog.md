## v4 - May 6 2020

* Fix showNumDays=0 for showing all data.
* Update a few common files, and move libweather files around.
* Update Dutch translations by @Vistaus (Pull Request #3)

## v3 - April 15 2020

* Support changing units (eg: Celsius to Fahrenheit) (https://github.com/Zren/plasma-applet-simpleweather/issues/15)
* Use 2 rows for EnvCan (day/night).
* Add "Refresh" to the contextmenu.
* No longer force a minimum widget size. If there's not enough room, it'll overflow. Fix a binding loop that can cause plasma to freeze on load.
* Fix showing current temp = 0°. It was treated as no data.

## v2 - January 21 2020

* Round details numbers when using Plasma 5.12 (Issue #1)

## v1 - January 18 2020

* Forked from "Daily Forecast" widget v3.
* Show current temp above the daily forecast.
* Limit daily forecast to 5 days by default.
* Parse and show current weather details to the right.
