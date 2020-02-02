// Version 1

import QtQuick 2.5
import QtQuick.Controls 2.5 as QtControls

import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.private.weather 1.0 as WeatherPlugin

QtControls.ComboBox {
	property string configKey

	textRole: "display"

	onCurrentIndexChanged: {
		if (configKey && model && model.unitIdForListIndex) {
			var nextValue = model.unitIdForListIndex(currentIndex)
			if (plasmoid.configuration[configKey] !== nextValue) {
				plasmoid.configuration[configKey] = nextValue
			}
		}
	}
}
