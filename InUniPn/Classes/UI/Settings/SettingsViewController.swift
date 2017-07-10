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

    private var notificationsSwitch = SwitchRowFormer<FormSwitchCell>() {
        $0.titleLabel.text = Strings.lessonsNotifications
    }.configure { (row) in
        row.switchWhenSelected = true
        row.switched = true
    }

    private var reminderIntervalPicker = InlinePickerRowFormer<FormInlinePickerCell, Int>() {
        $0.titleLabel.text = Strings.lessonsReminderInterval
        }.configure { row in

        }.onValueChanged { item in
            // Do Something
    }

    private var nameInput = TextFieldRowFormer<FormTextFieldCell>() {
        $0.titleLabel.text = Strings.name
        $0.textField.textAlignment = .right
        }.configure {
            $0.placeholder = Strings.namePlaceholder
    }
    
    private var universityPicker = InlinePickerRowFormer<FormInlinePickerCell, Int>() {
        $0.titleLabel.text = Strings.university
        }.configure { row in

        }.onValueChanged { item in
            // Do Something
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let notificationsHeaderView = LabelViewFormer<FormLabelHeaderView>() {
            $0.textLabel?.text = Strings.notifications
            }.configure { view in
        }

        let notificationSection = SectionFormer(rowFormer: notificationsSwitch, reminderIntervalPicker)
            .set(headerViewFormer: notificationsHeaderView)


        let accountHeaderView = LabelViewFormer<FormLabelHeaderView>() {
            $0.textLabel?.text = Strings.profile
            }.configure { view in
        }

        let accountSection = SectionFormer(rowFormer: nameInput, universityPicker)
            .set(headerViewFormer: accountHeaderView)

        former.append(sectionFormer: notificationSection, accountSection)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.navigationController?.title = Strings.settings
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
