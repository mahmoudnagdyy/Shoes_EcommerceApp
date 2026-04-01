//
//  LoginViewModel_Tests.swift
//  Shoes_EcommerceTests
//
//  Created by Mahmoud Nagdy on 01/04/2026.
//

import XCTest
@testable import Shoes_Ecommerce

@MainActor
final class LoginViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func test_LoginViewModel_loginWithEmailAndPassword_ShouldSucess() async throws {
        let mock = MockAuthManager()
        mock.shouldThrowError = false
        
        let vm = LoginViewModel(authManager: mock)
        
        try await vm.loginWithEmailAndPassword(email: "mahmoudnagdy@gmail.com", password: "123456")
        
        XCTAssertEqual(vm.email, "")
        XCTAssertEqual(vm.password, "")
    }
    
    func test_LoginViewModel_loginWithEmailAndPassword_ShouldThrowError() async throws {
        let mock = MockAuthManager()
        mock.shouldThrowError = true
        
        let vm = LoginViewModel(authManager: mock)
        
        do {
            try await vm.loginWithEmailAndPassword(email: "mahmoudnagdy@gmail.com", password: "123")
        } catch {
            XCTAssertNotNil(error)
        }
    }

}
