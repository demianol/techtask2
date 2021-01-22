//
//  tech_testUITests.swift
//  tech-testUITests
//
//  Created by Robert Majtan on 07/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import XCTest

class tech_testUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launchArguments = ["UITests"]
        app.launch()
        continueAfterFailure = false
    }

    override func tearDown() {
        
    }
    
    let hospitalName = "Spire South Bank Hospital"
    let hospitalType = "Hospital"
    let hospitalId = "18385"
    let hospitalPhone = "01905 350 003"
    let hospitalEmail = "spire.southbank@nhs.net"
    let hospitalAddress = "Worcester, WR5 3YB, Worcestershire"
    let hospitalOdsCode = "NT3"
    let hospitalCode = "NT301"
    let hospitalSector = "Independent Sector"
    let hospitalSubType = "Hospital"
    let hospitalFax = "01905 362 031"
    let pim = "True"
    let status = "Visible"
    
    func testHospitalSearch() {
        
        XCTContext.runActivity(named: "GIVEN Hospital App is lunched and hospital list is loaded") { _  in
            HospitalsListUtils.hospitalListIsLoaded(expectedNumberOfHospitalsOntheScreen: 3)
        }
        
        XCTContext.runActivity(named: "WHEN I search for \(hospitalName)") { _  in
            HospitalsListUtils.searchAndSelectHospital(hospitalName, selectCell: false)
        }
        
        XCTContext.runActivity(named: "THEN I verify \(hospitalName) card") { _  in
            HospitalsListUtils.verifyHospitalCard(hospitalNameLabel: hospitalName,
                                                  hospitalTypeLabel: hospitalType,
                                                  hospitalId: hospitalId,
                                                  hospitalPhoneLabel: hospitalPhone,
                                                  hospitalEmailLabel: hospitalEmail,
                                                  hospitalAddressLabel: hospitalAddress)
        }
    }
    
    func testHospitalDetails() {
        
        XCTContext.runActivity(named: "WHEN I search for \(hospitalName) and navigate to hospital details") { _  in            
            HospitalsListUtils.searchAndSelectHospital(hospitalName, selectCell: true)
        }
        
        XCTContext.runActivity(named: "THEN I verify \(hospitalName) details") { _  in
            HospitalsDetailsUtils.verifyHospitalDetails(hospitalName: hospitalName,
                                                        hospitalOdsCode: hospitalOdsCode,
                                                        hospitalId: hospitalId,
                                                        hospitalCode: hospitalCode,
                                                        hospitalType: hospitalType,
                                                        hospitalSubType: hospitalSubType,
                                                        hospitalStatus: status,
                                                        hospitalPim: pim,
                                                        hospitalAddress: hospitalAddress)
        }
        
        XCTContext.runActivity(named: "AND I can select email link and dismiss an alert") { _  in
            HospitalsDetailsUtils.selectLink(.email)
            HospitalsDetailsUtils.emailAlertActions(.no)
        }
        
        XCTContext.runActivity(named: "AND I can select email link and accept an alert") { _  in
            HospitalsDetailsUtils.selectLink(.email)
            HospitalsDetailsUtils.emailAlertActions(.yes)
        }
        
        XCTContext.runActivity(named: "AND I can select phone link and dismiss an alert") { _  in
            HospitalsDetailsUtils.selectLink(.phone)
            //HospitalsDetailsUtils.phoneAlertActions(.no) - due to bug this won't work for now
        }
        
        XCTContext.runActivity(named: "AND I verify map with Hospital location is visible") { _  in
            HospitalsDetailsUtils.mapWithHospitalLocationIsVisble(hospitalName)
        }
        
        XCTContext.runActivity(named: "AND I can select web link and I am navigated to Safari and go back to app") { _  in
            HospitalsDetailsUtils.selectLink(.web)
        }
        
        XCTContext.runActivity(named: "AND I navigate back to hospitals list page") { _  in
            HospitalsDetailsUtils.navigateBackToHospitalsList()
        }
    }
}

extension XCUIElement {
    func clearAndEnterText(_ text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        self.typeText(deleteString)
        self.typeText(text)
    }
    
    func waitForExistenceThenTap(timeout: TimeInterval = 1, message: String = "") {
        XCTAssertTrue(waitForExistence(timeout: timeout), message)
        tap()
    }
}
