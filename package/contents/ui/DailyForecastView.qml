import QtQuick 2.7
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import org.kde.plasma.private.weather 1.0 as WeatherPlugin

RowLayout {
	id: dailyForecastView
	spacing: units.smallSpacing

	//--- Settings
	readonly property int dateFontSize: plasmoid.configuration.dateFontSize * units.devicePixelRatio
	readonly property int minMaxFontSize: plasmoid.configuration.minMaxFontSize * units.devicePixelRatio
	
	readonly property int showNumDays: plasmoid.configuration.showNumDays
	readonly property bool showDailyBackground: plasmoid.configuration.showDailyBackground

	//--- Layout
	property alias model: dayRepeater.model

	// Note: minItemWidth causes a binding loop
	readonly property int minItemWidth: {
		var minWidth = 0
		for (var i = 0; i < dayRepeater.count; i++) {
			var item = dayRepeater.itemAt(i)
			if (!item.visible) {
				continue
			}
			if (i == 0 || item.width < minWidth) {
				minWidth = item.width
			}
		}
		return minWidth
	}

	Repeater {
		id: dayRepeater
		model: weatherData.dailyForecastModel

		Item {
			id: dayItem
			implicitWidth: dayItemLayout.implicitWidth + frame.margins.horizontal
			implicitHeight: dayItemLayout.implicitHeight + frame.margins.vertical
			Layout.fillWidth: true
			Layout.fillHeight: true

			visible: {
				if (dailyForecastView.showNumDays == 0) { // Show all
					return true
				} else {
					return (index+1) <= dailyForecastView.showNumDays
				}
			}

			PlasmaCore.FrameSvgItem {
				id: frame
				anchors.fill: parent
				visible: dailyForecastView.showDailyBackground
				imagePath: visible ? "widgets/background" : ""
			}

			ColumnLayout {
				id: dayItemLayout
				anchors.fill: parent
				anchors.leftMargin: frame.margins.left
				anchors.rightMargin: frame.margins.right
				anchors.topMargin: frame.margins.top
				anchors.bottomMargin: frame.margins.bottom
				spacing: 0

				WLabel {
					text: modelData.dayLabel || ""

					opacity: forecastLayout.fadedOpacity
					font.pixelSize: dailyForecastView.dateFontSize
					Layout.alignment: Qt.AlignHCenter
				}

				PlasmaCore.IconItem {
					Layout.fillWidth: true
					Layout.fillHeight: true
					Layout.maximumWidth: dailyForecastView.minItemWidth
					Layout.maximumHeight: dailyForecastView.minItemWidth
					Layout.alignment: Qt.AlignCenter
					source: modelData.forecastIcon
					roundToIconSize: false
					width: parent.width * 1.2
					height: parent.width * 1.2

					// Rectangle { anchors.fill: parent; color: "transparent"; border.width: 1; border.color: "#f00"}
				}

				ColumnLayout {
					Layout.alignment: Qt.AlignHCenter
					spacing: 0

					WLabel {
						readonly property var value: modelData.tempHigh

						readonly property bool hasValue: !isNaN(value)
						text: hasValue ? i18n("%1°", value) : ""
						// visible: hasValue
						font.pixelSize: dailyForecastView.minMaxFontSize
						Layout.alignment: Qt.AlignHCenter
					}

					WLabel {
						readonly property var value: modelData.tempLow
						opacity: forecastLayout.fadedOpacity

						readonly property bool hasValue: !isNaN(value)
						text: hasValue ? i18n("%1°", value) : ""
						// visible: hasValue
						font.pixelSize: dailyForecastView.minMaxFontSize
						Layout.alignment: Qt.AlignHCenter
					}
				}

				// Top align contents
				Item {
					Layout.fillWidth: true
					Layout.fillHeight: true
				}
			}

			PlasmaCore.ToolTipArea {
				anchors.fill: parent
				mainText: modelData.forecastLabel
			}

		}
	}

}
