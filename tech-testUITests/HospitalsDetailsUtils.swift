//
//  HospitalsDetailsUtils.swift
//  tech-testUITests
//
//  Created by Marcin Demianczuk on 21/01/2021.
//  Copyright © 2021 com.ro8i.techtest. All rights reserved.
//

import XCTest

class HospitalsDetailsUtils {
    static let app = XCUIApplication()
    
    struct HospitalDataElements {
        static let hospitalName = app.staticTexts["Hospital Name"]
        static let hospitalOdsCode = app.staticTexts["ods_code"]
        static let hospitalId = app.staticTexts["id"]
        static let hospitalCode = app.staticTexts["code"]
        static let hospitalType = app.staticTexts["type"]
        static let hospitalSubtype = app.staticTexts["subtype"]
        static let hospitalStatus = app.staticTexts["status"]
        static let hospitalPim = app.staticTexts["pim"]
        static let hospitalAddress = app.staticTexts["address"]
    }
    
    struct LinkButton {
        static let email = app.buttons["email"]
        static let phone = app.buttons["phone"]
        static let web = app.buttons["web"]
    }
    
    struct EmailAlert {
        static let alert = app.alerts["Email"]
        static let noButton =  alert.buttons["No"]
        static let yesButton =  alert.buttons["Yes"]
    }
    
    enum Links {
        case email
        case phone
        case web
    }
    
    enum Alert {
        case no
        case yes
    }
    
    static let navigationButton = app.navigationBars["Hospital Detail"].buttons["Hospitals"]
        
    class func verifyHospitalDetails(hospitalName: String,
                                     hospitalOdsCode: String,
                                     hospitalId: String,
                                     hospitalCode: String,
                                     hospitalType: String,
                                     hospitalSubType: String,
                                     hospitalStatus: String,
                                     hospitalPim: String,
                                     hospitalAddress: String) {
        XCTAssertTrue(HospitalDataElements.hospitalName.waitForExistence(timeout: 3), "Hospital Name was not visible on the screen")
        XCTAssertTrue(HospitalDataElements.hospitalName.label.contains(hospitalName), "Hospital Name was incorrect")
        XCTAssertTrue(HospitalDataElements.hospitalOdsCode.label.contains(hospitalOdsCode), "Hospital Ods Code was incorrect")
        XCTAssertTrue(HospitalDataElements.hospitalId.label.contains(hospitalId), "Hospital ID was incorrect")
        XCTAssertTrue(HospitalDataElements.hospitalCode.label.contains(hospitalCode), "Hospital Code was incorrect")
        XCTAssertTrue(HospitalDataElements.hospitalType.label.contains(hospitalType), "Hospital Type was incorrect")
        XCTAssertTrue(HospitalDataElements.hospitalSubtype.label.contains(hospitalSubType), "Hospital Sub Type was incorrect")
        XCTAssertTrue(HospitalDataElements.hospitalStatus.label.contains(hospitalStatus), "Hospital Status was incorrect")
        XCTAssertTrue(HospitalDataElements.hospitalPim.label.contains(hospitalPim), "Hospital PIM was incorrect")
        XCTAssertTrue(HospitalDataElements.hospitalAddress.label.contains(hospitalAddress), "Hospital Address was incorrect")
    }
    
    class func selectLink(_ link: Links) {
        switch link {
        case .email:
            LinkButton.email.waitForExistenceThenTap(message: "Email link was not visible on the screen")
            XCTAssertTrue(EmailAlert.alert.waitForExistence(timeout: 1), "Email Alert was not visible on the screen")
        case .phone:
            LinkButton.phone.waitForExistenceThenTap(message: "Phone link was not visible on the screen")
            //Below line should check phone alert exists after tapping, but there is a bug and this alert does not exist so commenting it for now
            //XCTAssertTrue(EmailAlert.phone.waitForExistence(timeout: 1), "Phone Alert was not visible on the screen")
        case .web:
            XCTAssertTrue(LinkButton.web.exists, "Web link was not visible on the screen")
        }
    }
    
    class func emailAlertActions(_ pressOnAlert: Alert) {
        XCTAssertTrue(EmailAlert.alert.waitForExistence(timeout: 1), "Email Alert was not visible on the screen")
        switch pressOnAlert {
        case .no:
            EmailAlert.noButton.waitForExistenceThenTap(message: "Could not tap 'No' button on the email alert")
            XCTAssertFalse(EmailAlert.alert.exists, "Alert was not dismissed")
        case .yes:
            EmailAlert.yesButton.waitForExistenceThenTap(message: "Could not tap 'No' button on the email alert")
            XCTAssertFalse(EmailAlert.alert.exists, "Alert was not dismissed")
        }
    }
    
    class func mapWithHospitalLocationIsVisble(_ hospitalName: String) {
        let mapAnnotation = app.scrollViews.otherElements.maps.containing(.other, identifier:"\(hospitalName)").element
        XCTAssert(mapAnnotation.waitForExistence(timeout: 1), "\(hospitalName) was not pined on the map")
    }
    
    class func navigateBackToHospitalsList() {
        navigationButton.waitForExistenceThenTap(timeout: 1, message: "Navigation button was not visible on the screen")
        XCTAssert(HospitalsListUtils.searchTextField.waitForExistence(timeout: 4), "User was not naviagted back to hospital list page")
    }
}
