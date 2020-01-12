import QtQuick 2.7
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import org.kde.plasma.private.weather 1.0 as WeatherPlugin

RowLayout {
	id: currentWeatherView

	//--- Settings
	readonly property int forecastFontSize: plasmoid.configuration.forecastFontSize * units.devicePixelRatio
	readonly property int tempFontSize: plasmoid.configuration.tempFontSize * units.devicePixelRatio

	//--- Layout
	PlasmaCore.IconItem {
		id: currentForecastIcon
		Layout.fillHeight: true
		Layout.minimumWidth: currentConditionsColumn.implicitHeight
		source: weatherData.currentConditionIconName
		roundToIconSize: false

		// Rectangle { border.color: "#ff0"; color: "transparent"; border.width: 1; anchors.fill: parent; }
	}

	ColumnLayout {
		id: currentConditionsColumn
		spacing: 0
		Layout.fillHeight: true

		WLabel {
			// Layout.minimumWidth: 0
			Layout.fillWidth: true
			id: currentConditionsLabel
			text: weatherData.todaysForecastLabel
			font.pixelSize: currentWeatherView.forecastFontSize
			elide: Text.ElideRight
			// wrapMode: Text.Wrap

			PlasmaCore.ToolTipArea {
				anchors.fill: parent
				mainText: currentConditionsLabel.text
				enabled: currentConditionsLabel.truncated
			}
		}

		Item {
			implicitHeight: currentTempLabel.font.pixelSize
			implicitWidth: currentTempLabel.implicitWidth

			WLabel {
				id: currentTempLabel
				anchors.verticalCenter: parent.verticalCenter
				font.pixelSize: currentWeatherView.tempFontSize
				readonly property var value: weatherData.currentTemp
				readonly property bool hasValue: !isNaN(value)
				text: hasValue ? i18n("%1°", Math.round(value)) : ""

				// Rectangle { border.color: "#f00"; color: "transparent"; border.width: 1; anchors.fill: parent; }
			}

			// Rectangle { border.color: "#ff0"; color: "transparent"; border.width: 1; anchors.fill: parent; }
		}
	}
}
