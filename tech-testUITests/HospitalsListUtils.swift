//
//  HospitalsListView.swift
//  tech-testUITests
//
//  Created by Marcin Demianczuk on 21/01/2021.
//  Copyright © 2021 com.ro8i.techtest. All rights reserved.
//

import XCTest

class HospitalsListUtils {
    static let app = XCUIApplication()
    static let searchTextField = app.searchFields.element
    
    struct HospitalCardElements {
        static let firstTableCell = app.tables.cells["cell_0"]
        static let hospitalNameLabel = firstTableCell.staticTexts["hospitalNameLabel"]
        static let hospitalTypeLabel = firstTableCell.staticTexts["hospitalTypeLabel"]
        static let hospitalId = firstTableCell.staticTexts["hospitalId"]
        static let hospitalPhoneLabel = firstTableCell.staticTexts["hospitalPhoneLabel"]
        static let hospitalEmailLabel = firstTableCell.staticTexts["hospitalEmailLabel"]
        static let hospitalAddressLabel = firstTableCell.staticTexts["hospitalAddressLabel"]
    }
    
    class func hospitalListIsLoaded(expectedNumberOfHospitalsOntheScreen: Int) {
        
        var tableCell = app.tables.cells["cell_0"]
        XCTAssertTrue(tableCell.waitForExistence(timeout: 1), "Table cell: 1 was not loaded correctly")
        for index in 1 ... expectedNumberOfHospitalsOntheScreen {
            tableCell = app.tables.cells["cell_\(index)"]
            XCTAssertTrue(tableCell.waitForExistence(timeout: 1), "Table cell: \(index) was not loaded correctly")
        }
    }
    
    class func searchAndSelectHospital(_ hospitalName: String, selectCell: Bool) {
        searchTextField.waitForExistenceThenTap(timeout: 3, message: "Search Text Field was not visible on the screen")
        searchTextField.clearAndEnterText(hospitalName)
        let numberOftableCells = app.tables.cells.count
        XCTAssertEqual(numberOftableCells, 1, "There was more then one search result")
        if selectCell {
            HospitalCardElements.hospitalNameLabel.waitForExistenceThenTap(timeout: 2, message: "Hospital Name was not on the screen")
        }
    }
    
    class func verifyHospitalCard(hospitalNameLabel: String,
                                  hospitalTypeLabel: String,
                                  hospitalId: String,
                                  hospitalPhoneLabel: String? = nil,
                                  hospitalEmailLabel: String? = nil,
                                  hospitalAddressLabel: String) {
        XCTAssertTrue(HospitalCardElements.hospitalNameLabel.label.contains(hospitalNameLabel), "Hospital Name was incorrect")
        XCTAssertTrue(HospitalCardElements.hospitalTypeLabel.label.contains(hospitalTypeLabel), "Hospital Type was incorrect")
        XCTAssertTrue(HospitalCardElements.hospitalId.label.contains(hospitalId), "Hospital ID was incorrect")
        if let hospitalPhoneLabel = hospitalPhoneLabel {
            XCTAssertTrue(HospitalCardElements.hospitalPhoneLabel.label.contains(hospitalPhoneLabel), "Hospital Phone was incorrect")
        }
        if let hospitalEmailLabel = hospitalEmailLabel {
            XCTAssertTrue(HospitalCardElements.hospitalEmailLabel.label.contains(hospitalEmailLabel), "Hospital Email was incorrect")
        }
        XCTAssertTrue(HospitalCardElements.hospitalAddressLabel.label.contains(hospitalAddressLabel), "Hospital Address was incorrect")
    }
    
}


