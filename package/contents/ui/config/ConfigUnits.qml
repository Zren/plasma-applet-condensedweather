import QtQuick 2.5
import QtQuick.Controls 2.5 as QtControls

import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.private.weather 1.0 as WeatherPlugin


Kirigami.FormLayout {

	UnitComboBox {
		configKey: 'temperatureUnitId'
		Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:listbox", "Temperature:")
		model: WeatherPlugin.TemperatureUnitListModel
	}

	UnitComboBox {
		configKey: 'pressureUnitId'
		Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:listbox", "Pressure:")
		model: WeatherPlugin.PressureUnitListModel
	}

	UnitComboBox {
		configKey: 'windSpeedUnitId'
		Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:listbox", "Wind speed:")
		model: WeatherPlugin.WindSpeedUnitListModel
	}

	UnitComboBox {
		configKey: 'visibilityUnitId'
		Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:listbox", "Visibility:")
		model: WeatherPlugin.VisibilityUnitListModel
	}

}
