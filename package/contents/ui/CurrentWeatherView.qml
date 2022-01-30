import QtQuick 2.7
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore

RowLayout {
	id: currentWeatherView

	//--- Settings
	readonly property int forecastFontSize: plasmoid.configuration.forecastFontSize * PlasmaCore.Units.devicePixelRatio
	readonly property int tempFontSize: plasmoid.configuration.tempFontSize * PlasmaCore.Units.devicePixelRatio

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
			Layout.preferredWidth: 160 * PlasmaCore.Units.devicePixelRatio
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
				text: hasValue ? weatherData.formatTempShort(value) : ""

				// Rectangle { border.color: "#f00"; color: "transparent"; border.width: 1; anchors.fill: parent; }
			}

			// Rectangle { border.color: "#ff0"; color: "transparent"; border.width: 1; anchors.fill: parent; }
		}
	}
}
