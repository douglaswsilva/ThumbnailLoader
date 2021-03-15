//
//  ThumbnailLoaderExampleTests.swift
//  ThumbnailLoaderExampleTests
//
//  Created by Douglas on 15/03/21.
//

import XCTest
import ThumbnailLoaderExample

class ThumbnailLoaderExampleTests: XCTestCase {

    // test_methodName_someSetup_expectedOutcome
    func test_loadThumbnail_withInvalidURL_completesWithError() {
        // Given
        let sut = makeSUT()
        
        // When
        let (_, receivedError) = load(with: anyInvalidURL(), sut: sut)
        
        // Then
        XCTAssertNotNil(receivedError)
    }
    
    func test_loadThumbnail_completesSuccessfully() {
        // Given
        let sut = makeSUT()
        let url = anyURL()
        let data = anyData()
        
        // When
        addData(data: data, to: url)
        let received = load(with: url, sut: sut)
        
        // Then
        XCTAssertNil(received.error)
        XCTAssertNotNil(received.data)
        XCTAssertEqual(received.data, data)
    }
    
    func test_loadThumbnail_completesAfterSUTDeallocation() {
        // Given
        var sut: LocalThumbnailLoader? = LocalThumbnailLoader()
        
        // When
        let exp = expectation(description: "Wait for completion")
        sut?.loadThumbnail(with: anyInvalidURL(), completion: { _ in
            exp.fulfill()
        })
        sut = nil
        
        // Then
        let result = XCTWaiter.wait(for: [exp], timeout: 1)
        if result == .timedOut {
            print("Success")
        } else {
            XCTFail("It should not have completed, because sut is nil.")
        }
    }
    
    // MARK: - Helper
    func makeSUT() -> LocalThumbnailLoader {
        let sut = LocalThumbnailLoader()
        return sut
    }
    
    func load(with url: URL, sut: LocalThumbnailLoader) -> (data: Data?, error: Error?) {
        var receivedError: Error?
        var receivedData: Data?
        
        let exp = expectation(description: "Wait for completion")
        sut.loadThumbnail(with: url) { result in
            switch result {
            case let .failure(error):
                receivedError = error
            case let .success(data):
                receivedData = data
            }
            
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
        
        return (receivedData, receivedError)
    }
    
    func documentDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func anyURL() -> URL {
        documentDirectory().appendingPathComponent("MyImage.png")
    }
    
    func anyInvalidURL() -> URL {
        URL(string: "http://any-url.com")!
    }
    
    func anyData() -> Data {
        Data()
    }
    
    func addData(data: Data, to url: URL) {
        try? data.write(to: url)
    }
}
