//
//  LessonsTableViewDelegate.swift
//  InUniPn
//
//  Created by Damiano Giusti on 04/07/17.
//  Copyright © 2017 KDev. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class LessonsTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {

    var cellNibName = ""
    var cellReuseIdentifier = ""

    var dataset: [Day] = []
    var filteredDataset: [Day] = []

    var didSelectRowAtIndexPathClosure: ((UITableView, IndexPath) -> Void)?
    var scrollViewWillBeginDraggingClosure: ((UIScrollView) -> Void)?
    var scrollViewDidScrollClosure: ((UIScrollView) -> Void)?

    fileprivate var isFilterEnabled: Bool {
        return !filteredDataset.isEmpty
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if !filteredDataset.isEmpty {
            return filteredDataset.count
        }
        return dataset.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilterEnabled {
            return filteredDataset[section].lessons.count
        }
        if !dataset.isEmpty {
            return dataset[section].lessons.count
        }
        return 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LessonTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath as IndexPath) as! LessonTableViewCell

        let lesson: LessonToDisplay
        if isFilterEnabled {
            lesson = filteredDataset[indexPath.section].lessons[indexPath.row]

        } else {
            lesson = dataset[indexPath.section].lessons[indexPath.row]
        }

        cell.selectionStyle = .none
        cell.startTimeLabel?.text = lesson.startTime
        cell.endTimeLabel?.text = lesson.endTime
        cell.lessonLabel?.text = lesson.name
        cell.teacherLabel?.text = lesson.teacher
        cell.classroomLabel?.text = lesson.classroom

        return cell
    }


    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if dataset.count > 0{
            return dataset[section].date
        }
        return ""
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAtIndexPathClosure?(tableView, indexPath)
    }

}

// MARK: - TableView Empty

extension LessonsTableViewDelegate: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: Strings.noLessonsPresent)
    }
}
