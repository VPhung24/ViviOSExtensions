//
//  VivUIExtensionsUserDefaultsContactTests.swift
//  VivUIExtensions
//
//  Created by Vivian Phung on 11/22/22.
//

import XCTest
import Foundation
import Contacts
@testable import VivUIExtensions

final class VivUIExtensionsUserDefaultsContactTests: XCTestCase {
    func testContactUserDefaultsExtension() throws {
        let contact = CNMutableContact()
        contact.givenName = "TestGivenName"
        
        UserDefaults.standard.set(contact, forKey: "Contact")
        
        let retrivedContact = UserDefaults.standard.contact(forKey: "Contact")
        XCTAssertEqual(contact, retrivedContact)
    }
}
