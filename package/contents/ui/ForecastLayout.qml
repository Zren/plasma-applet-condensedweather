import QtQuick 2.7
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import org.kde.plasma.private.weather 1.0 as WeatherPlugin

RowLayout {
	id: forecastLayout
	spacing: units.largeSpacing

	opacity: weatherData.hasData ? 1 : 0
	Behavior on opacity { NumberAnimation { duration: 1000 } }

	//--- Settings
	readonly property color textColor: plasmoid.configuration.textColor || theme.textColor
	readonly property color outlineColor: plasmoid.configuration.outlineColor || theme.backgroundColor

	readonly property bool showOutline: plasmoid.configuration.showOutline

	readonly property string fontFamily: plasmoid.configuration.fontFamily || theme.defaultFont.family
	readonly property var fontBold: plasmoid.configuration.bold ? Font.Bold : Font.Normal

	readonly property real fadedOpacity: 0.7

	//--- Layout
	ColumnLayout {
		
		CurrentWeatherView {
			id: currentWeatherView
		}

		DailyForecastView {
			id: dailyForecastView
		}
	}

	ColumnLayout {
		Layout.alignment: Qt.AlignTop
		spacing: units.smallSpacing

		DetailsView {
			id: detailsView
			model: weatherData.detailsModel
		}

		PlasmaComponents.Label {
			text: ""
		}

		PlasmaComponents.Label {
			id: updatedAtLabel
			Layout.fillWidth: true
			horizontalAlignment: Text.AlignHCenter
			readonly property var value: weatherData.oberservationTimestamp
			readonly property bool hasValue: !!value // && !isNaN(new Date(value))
			readonly property date valueDate: hasValue ? new Date(value) : new Date()
			text: {
				if (hasValue) {
					var timestamp = Qt.formatTime(valueDate, Qt.DefaultLocaleShortDate)
					if (timestamp) {
						return i18n("Updated at %1", timestamp)
					} else {
						return ""
					}
				} else {
					return ""
				}
			}
			opacity: 0.6
			wrapMode: Text.Wrap
		}

		PlasmaComponents.Label {
			id: locationLabel
			Layout.fillWidth: true
			horizontalAlignment: Text.AlignHCenter
			readonly property var value: weatherData.location
			readonly property bool hasValue: !!value
			text: hasValue ? value : ""
			opacity: 0.6
			wrapMode: Text.Wrap
		}
	}
}
