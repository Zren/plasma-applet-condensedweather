import QtQuick 2.7
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore

RowLayout {
	id: forecastLayout
	spacing: PlasmaCore.Units.largeSpacing

	opacity: weatherData.hasData ? 1 : 0
	Behavior on opacity { NumberAnimation { duration: 1000 } }

	//--- Settings
	readonly property color textColor: plasmoid.configuration.textColor || PlasmaCore.Theme.textColor
	readonly property color outlineColor: plasmoid.configuration.outlineColor || PlasmaCore.Theme.backgroundColor

	readonly property bool showOutline: plasmoid.configuration.showOutline

	readonly property string fontFamily: plasmoid.configuration.fontFamily || PlasmaCore.Theme.defaultFont.family
	readonly property var fontBold: plasmoid.configuration.bold ? Font.Bold : Font.Normal

	readonly property real fadedOpacity: 0.7

	//--- Layout
	ColumnLayout {
		spacing: PlasmaCore.Units.smallSpacing

		CurrentWeatherView {
			id: currentWeatherView
		}

		DailyForecastView {
			id: dailyForecastView
		}
	}

	DetailsView {
		id: detailsView
		visible: plasmoid.configuration.showDetails
		Layout.alignment: Qt.AlignTop
		model: weatherData.detailsModel
	}
}
