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

	DetailsView {
		id: detailsView
		Layout.alignment: Qt.AlignTop
		model: weatherData.detailsModel
	}
}
