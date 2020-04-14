import QtQuick 2.5
import QtQuick.Controls 2.5 as QtControls

import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.private.weather 1.0 as WeatherPlugin

import ".."

Kirigami.FormLayout {

	DisplayUnits { id: displayUnits }

	Component.onCompleted: {
		temperatureComboBox.populateWith(displayUnits.temperatureUnitId)
		pressureComboBox.populateWith(displayUnits.pressureUnitId)
		windSpeedComboBox.populateWith(displayUnits.windSpeedUnitId)
		visibilityComboBox.populateWith(displayUnits.visibilityUnitId)
	}

	UnitComboBox {
		id: temperatureComboBox
		configKey: 'temperatureUnitId'
		Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:listbox", "Temperature:")
		model: WeatherPlugin.TemperatureUnitListModel
	}

	UnitComboBox {
		id: pressureComboBox
		configKey: 'pressureUnitId'
		Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:listbox", "Pressure:")
		model: WeatherPlugin.PressureUnitListModel
	}

	UnitComboBox {
		id: windSpeedComboBox
		configKey: 'windSpeedUnitId'
		Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:listbox", "Wind speed:")
		model: WeatherPlugin.WindSpeedUnitListModel
	}

	UnitComboBox {
		id: visibilityComboBox
		configKey: 'visibilityUnitId'
		Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:listbox", "Visibility:")
		model: WeatherPlugin.VisibilityUnitListModel
	}

}
