import QtQuick 2.0
import org.kde.plasma.configuration 2.0

ConfigModel {
	ConfigCategory {
		name: i18n("General")
		icon: "configure"
		source: "config/ConfigGeneral.qml"
	}
	ConfigCategory {
		name: i18ndc("plasma_applet_org.kde.plasma.weather", "@title", "Units")
		icon: "preferences-other"
		source: "config/ConfigUnits.qml"
	}
}
