import QtQuick 2.7
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import org.kde.plasma.private.weather 1.0 as WeatherPlugin

Item {
	id: widget

	WeatherData {
		id: weatherData
	}

	Plasmoid.icon: weatherData.currentConditionIconName
	Plasmoid.toolTipMainText: weatherData.currentConditions

	Plasmoid.fullRepresentation: Item {
		readonly property bool isDesktopContainment: plasmoid.location == PlasmaCore.Types.Floating
		Plasmoid.backgroundHints: isDesktopContainment && !plasmoid.configuration.showBackground ? PlasmaCore.Types.NoBackground : PlasmaCore.Types.DefaultBackground

		property Item contentItem: weatherData.needsConfiguring ? configureButton : forecastLayout
		implicitWidth: contentItem.implicitWidth
		implicitHeight: contentItem.implicitHeight
		Layout.minimumWidth: implicitWidth
		Layout.minimumHeight: implicitHeight

		PlasmaComponents.Button {
			id: configureButton
			anchors.centerIn: parent
			visible: weatherData.needsConfiguring
			text: i18ndc("plasma_applet_org.kde.plasma.weather", "@action:button", "Configure...")
			onClicked: plasmoid.action("configure").trigger()
		}

		RowLayout {
			id: forecastLayout
			anchors.fill: parent
			spacing: units.largeSpacing
			visible: !weatherData.needsConfiguring

			ColumnLayout {
				RowLayout {

					PlasmaCore.IconItem {
						id: currentForecastIcon
						Layout.fillHeight: true
						// Layout.minimumWidth: currentConditionsColumn.implicitHeight
						Layout.minimumWidth: height
						source: weatherData.currentConditionIconName
						roundToIconSize: false

						// Rectangle { border.color: "#ff0"; color: "transparent"; border.width: 1; anchors.fill: parent; }
					}

					ColumnLayout {
						id: currentConditionsColumn
						spacing: 0
						Layout.fillHeight: true

						PlasmaComponents.Label {
							id: currentConditionsLabel
							text: weatherData.todaysForecastLabel
							// font.family: currentWeatherView.fontFamily
							// font.weight: currentWeatherView.fontBold
							// color: currentWeatherView.textColor
							// style: currentWeatherView.showOutline ? Text.Outline : Text.Normal
							// styleColor: currentWeatherView.outlineColor
						}

						Item {
							implicitHeight: 60 * units.devicePixelRatio
							implicitWidth: currentTempLabel.implicitWidth

							PlasmaComponents.Label {
								id: currentTempLabel
								anchors.centerIn: parent
								font.pointSize: -1
								font.pixelSize: 60 * units.devicePixelRatio
								readonly property var value: weatherData.currentTemp
								readonly property bool hasValue: !isNaN(value)
								text: hasValue ? i18n("%1°", Math.round(value)) : ""
								// font.family: currentWeatherView.fontFamily
								// font.weight: currentWeatherView.fontBold
								// color: currentWeatherView.textColor
								// style: currentWeatherView.showOutline ? Text.Outline : Text.Normal
								// styleColor: currentWeatherView.outlineColor

								// Rectangle { border.color: "#f00"; color: "transparent"; border.width: 1; anchors.fill: parent; }
							}

							// Rectangle { border.color: "#ff0"; color: "transparent"; border.width: 1; anchors.fill: parent; }
						}

						
					}
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

	}


	Component.onCompleted: {
		// plasmoid.action("configure").trigger()
	}
}
