import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

RowLayout {
	id: forecastLayout
	spacing: Kirigami.Units.largeSpacing

	opacity: weatherData.hasData ? 1 : 0
	Behavior on opacity { NumberAnimation { duration: 1000 } }

	//--- Settings
	readonly property color textColor: plasmoid.configuration.textColor || Kirigami.Theme.textColor
	readonly property color outlineColor: plasmoid.configuration.outlineColor || Kirigami.Theme.backgroundColor

	readonly property bool showOutline: plasmoid.configuration.showOutline

	readonly property string fontFamily: plasmoid.configuration.fontFamily || Kirigami.Theme.defaultFont.family
	readonly property var fontBold: plasmoid.configuration.bold ? Font.Bold : Font.Normal

	readonly property real fadedOpacity: 0.7

	//--- Layout
	ColumnLayout {
		spacing: Kirigami.Units.smallSpacing

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
