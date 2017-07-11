//
//  SettingsViewController.swift
//  InUniPn
//
//  Created by Damiano Giusti on 10/07/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit
import Former

class SettingsViewController: FormViewController {

    var user: User?

    fileprivate var notificationsSwitch: SwitchRowFormer<FormSwitchCell>?
    fileprivate var reminderIntervalPicker: InlinePickerRowFormer<FormInlinePickerCell, Int>?
    fileprivate var nameInput: TextFieldRowFormer<FormTextFieldCell>?
    fileprivate var universityPicker: InlinePickerRowFormer<FormInlinePickerCell, Int>?
    fileprivate var logoutItem: LabelRowFormer<FormLabelCell>?

    private let presenter = SettingsPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.notificationsSwitch = SwitchRowFormer<FormSwitchCell>() {
            $0.titleLabel.text = Strings.lessonsNotifications
            }.configure { (row) in
                row.switchWhenSelected = true
                row.switched = true
        }.onSwitchChanged(self.presenter.changeNotificationStatus)

        self.reminderIntervalPicker = InlinePickerRowFormer<FormInlinePickerCell, Int>() {
            $0.titleLabel.text = Strings.lessonsReminderInterval
            }.configure { row in

            }.onValueChanged { item in
                self.presenter.changeNotificationInterval(newValueMinutes: item.value)
        }

        self.nameInput = TextFieldRowFormer<FormTextFieldCell>() {
            $0.titleLabel.text = Strings.name
            $0.textField.textAlignment = .right
            }.configure {
                $0.placeholder = Strings.namePlaceholder
        }

        self.universityPicker = InlinePickerRowFormer<FormInlinePickerCell, Int>() {
            $0.titleLabel.text = Strings.university
            }.configure { row in

            }.onValueChanged { item in
                self.presenter.changeUniversity(uni: item.title)
        }

        self.logoutItem = LabelRowFormer<FormLabelCell>() {
            $0.titleLabel.textColor = .red
        }.configure(handler: { row in
            row.text = Strings.logout
        }).onSelected({ item in
            self.presenter.logout()
        })

        presenter.create(withView: self)
        presenter.retrieveUniversities()

        let notificationsHeaderView = LabelViewFormer<FormLabelHeaderView>() {
            $0.textLabel?.text = Strings.notifications
        }

        let notificationSection = SectionFormer(rowFormer: notificationsSwitch!, reminderIntervalPicker!)
            .set(headerViewFormer: notificationsHeaderView)


        let accountHeaderView = LabelViewFormer<FormLabelHeaderView>() {
            $0.textLabel?.text = Strings.profile
            }.configure { view in
        }

        let accountSection = SectionFormer(rowFormer: nameInput!, universityPicker!, logoutItem!)
            .set(headerViewFormer: accountHeaderView)

        former.append(sectionFormer: notificationSection, accountSection)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.navigationController?.title = Strings.settings
    }


    override func viewWillDisappear(_ animated: Bool) {
        presenter.changeUserName(name: nameInput?.text)
    }

}

extension SettingsViewController: SettingsView {

    func showMessage(withMessage message: String) {

    }

    func showError(withError error: String) {

    }

    func showUserName(name: String?) {
        nameInput?.text = name
        nameInput?.update()
    }

    func showUniversities(unis: [University], withSelection selection: String?, atIndex index: Int?) {
        universityPicker?.configure(handler: { row in
            row.pickerItems = unis.enumerated().map { index, uni in
                InlinePickerItem(title: uni.code ?? "", value: Int(index))
            }
        })
        if let index = index {
            universityPicker?.selectedRow = index
        }

        universityPicker?.update()
    }

    func showNotifyForLessons(enabled: Bool) {
        notificationsSwitch?.switched = enabled
        notificationsSwitch?.update()
    }

    func showReminderIntervals(intervals: [String]) {
        var index = 0
        reminderIntervalPicker?.pickerItems.append(contentsOf:
            intervals.map({ title in
                index = index + 1
                return InlinePickerItem(title: title, value: index)
            }))
        reminderIntervalPicker?.update()
    }

    func showLessonsReminderInterval(string: String, rawValue: Int) {
        reminderIntervalPicker?.selectedRow = rawValue - 1
        reminderIntervalPicker?.update()
    }

    func navigateToLogin() {
        let dialog = UIAlertController(title: Strings.logout, message: Strings.confirmLogoutMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.appDelegate.logout()
        }
        let cancelAction = UIAlertAction(title: Strings.cancel , style: .cancel, handler: { action in
            self.logoutItem?.cell.setSelected(false, animated: true)
        })
        dialog.addAction(okAction)
        dialog.addAction(cancelAction)
        present(dialog, animated: true, completion: nil)
    }
}
