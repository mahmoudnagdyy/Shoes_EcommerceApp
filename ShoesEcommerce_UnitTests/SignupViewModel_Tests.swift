//
//  SignupViewModel_Tests.swift
//  Shoes_EcommerceTests
//
//  Created by Mahmoud Nagdy on 01/04/2026.
//

import XCTest
@testable import Shoes_Ecommerce

@MainActor
final class SignupViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SignupViewModel_signUpWithEmailAndPassword_ShouldSucess() async throws {
        let mock = MockAuthManager()
        mock.shouldThrowError = false
        
        let vm = SignupViewModel(authManager: mock)
        
        try await vm.signupWithEmailAndPassword(firstName: "mahmoud", lastName: "nagdy", email: "mahmoudnagdy@gmail.com", password: "123123")
        
        XCTAssertEqual(vm.firstName, "")
        XCTAssertEqual(vm.lastName, "")
        XCTAssertEqual(vm.email, "")
        XCTAssertEqual(vm.password, "")
    }
    
    
    func test_SignupViewModel_signUpWithEmailAndPassword_ShouldThrowError() async throws {
        let mock = MockAuthManager()
        mock.shouldThrowError = true
        
        let vm = SignupViewModel(authManager: mock)
        
        do {
            try await vm.signupWithEmailAndPassword(firstName: "mahmoud", lastName: "nagdy", email: "mahmoudnagdy@gmail.com", password: "123123")
            
            XCTFail("Should Fail")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
}
