import QtQuick 2.0

QtObject {
	// https://doc.qt.io/qt-5/qml-qtqml-locale.html#measurementSystem-prop
	readonly property bool localeUsesMetric: Qt.locale().measurementSystem == Locale.MetricSystem
	
	readonly property int temperatureUnitId: {
		if (plasmoid.configuration.temperatureUnitId === 0) { // Use locale default
			if (localeUsesMetric) {
				return 6001 // Celcius
			} else {
				return 6002 // Fahrenheit
			}
		} else {
			return plasmoid.configuration.temperatureUnitId
		}
	}
	readonly property int windSpeedUnitId: {
		if (plasmoid.configuration.windSpeedUnitId === 0) { // Use locale default
			if (localeUsesMetric) {
				return 9000 // MeterPerSecond
			} else {
				return 9002 // MilePerHour
			}
		} else {
			return plasmoid.configuration.windSpeedUnitId
		}
	}
	readonly property int pressureUnitId: {
		if (plasmoid.configuration.pressureUnitId === 0) { // Use locale default
			if (localeUsesMetric) {
				return 5008 // Hectopascal
			} else {
				return 5028 // InchesOfMercury
			}
		} else {
			return plasmoid.configuration.pressureUnitId
		}
	}
	readonly property int visibilityUnitId: {
		if (plasmoid.configuration.visibilityUnitId === 0) { // Use locale default
			if (localeUsesMetric) {
				return 2007 // Kilometer
			} else {
				return 2024 // Mile
			}
		} else {
			return plasmoid.configuration.visibilityUnitId
		}
	}
}
