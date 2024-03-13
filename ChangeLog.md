## v6 - March 13 2024

* Port to Plasma 6
* Updated Dutch translation by @Vistaus (PR #10)

## v5 - February 13 2022

* Port to `QtQuick.Controls 2.0`, `PlasmaComponents 3.0`, and `Kirigami` config. Should work in Ubuntu 20.04 with Qt 5.12 and KDE Frameworks 5.68.
* Merge changes to weather widget from upstream KDE weather widget.
* Port missing `ServiceListModel` in Plasma 5.24 to use the `weatherDataSource.data['ions']` to get the list of weather data websites.
* Use PlasmaCore Unit/Theme singletons.
* Refactor dailyForecastModel to check if data exists.
* Update i18n scripts.
* Add Croatian translations by @VladimirMikulic (synced from simpleweather)
* Add Slovenian translations by @Ugowsky (synced from simpleweather)
* Updated Russian translations by @Morion-Self (Pull Request #9)

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
