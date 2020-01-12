/*
 * Copyright 2018  Friedrich W. H. Kossebau <kossebau@kde.org>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.9

import QtQuick.Layouts 1.3

import org.kde.plasma.components 3.0 as PlasmaComponents

ColumnLayout {
	id: detailsView
	spacing: units.smallSpacing

	property var model

	//--- Settings
	readonly property int detailsFontSize: plasmoid.configuration.detailsFontSize * units.devicePixelRatio

	//--- Layout
	GridLayout {
		Layout.alignment: Qt.AlignTop | Qt.AlignHCenter

		rowSpacing: units.smallSpacing

		Repeater {
			id: labelRepeater

			model: detailsView.model

			delegate: Loader {
				readonly property int rowIndex: index
				readonly property var rowData: modelData

				Layout.minimumWidth: item.Layout.minimumWidth
				Layout.minimumHeight: item.Layout.minimumHeight
				Layout.alignment: item.Layout.alignment
				Layout.preferredWidth: item.Layout.preferredWidth
				Layout.preferredHeight: item.Layout.preferredHeight
				Layout.row: rowIndex
				Layout.column: 0

				sourceComponent: WLabel {
					Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
					opacity: forecastLayout.fadedOpacity

					text: rowData.label

					font.pixelSize: detailsView.detailsFontSize
				}
			}
		}

		Repeater {
			id: repeater

			model: detailsView.model

			delegate: Loader {
				readonly property int rowIndex: index
				readonly property var rowData: modelData

				Layout.minimumWidth: item.Layout.minimumWidth
				Layout.minimumHeight: item.Layout.minimumHeight
				Layout.alignment: item.Layout.alignment
				Layout.preferredWidth: item.Layout.preferredWidth
				Layout.preferredHeight: item.Layout.preferredHeight
				Layout.row: rowIndex
				Layout.column: 1

				sourceComponent: WLabel {
					Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
					text: rowData.text
					font.pixelSize: detailsView.detailsFontSize
				}
			}
		}
	}

	WLabel {
		text: ""
	}

	WLabel {
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

	WLabel {
		id: locationLabel
		Layout.fillWidth: true
		horizontalAlignment: Text.AlignHCenter
		readonly property var value: weatherData.location
		readonly property bool hasValue: !!value
		text: hasValue ? value : ""
		opacity: 0.6
		wrapMode: Text.Wrap
	}

	NoticesListView {
		Layout.fillWidth: true
		model: weatherData.watchesModel
		readonly property bool showWatches: plasmoid.configuration.showWarnings
		visible: showWatches && model.length > 0
		state: "Watches"
		horizontalAlignment: Text.AlignHCenter
	}

	NoticesListView {
		Layout.fillWidth: true
		model: weatherData.warningsModel
		readonly property bool showWarnings: plasmoid.configuration.showWarnings
		visible: showWarnings && model.length > 0
		state: "Warnings"
		horizontalAlignment: Text.AlignHCenter
	}
}
