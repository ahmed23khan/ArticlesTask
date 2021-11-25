//
//  ArticlesTests.swift
//  ArticlesTests
//
//  Created by Tauqeer Ahmed Khan on 25/11/21.
//

import XCTest
@testable import Articles

class ArticlesTests: XCTestCase {
    
    var sut: ArticleViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ArticleViewModel()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil;
    }
    
    func testNewsFetchCallsResume() {
        // given
        let session = URLSessionMock()
        let news = URLSessionProvider(session: session)
        let expectation = XCTestExpectation(description: "Hitting the Article API triggers resume().")
        
        // when
        news.request(type: Artilces.self, service: Period.seven) { response in
            XCTAssertTrue(session.dataTask?.resumeWasCalled ?? false)
            expectation.fulfill()
        }
        // then
        wait(for: [expectation], timeout: 5)
    }
    
    func testNewsFetchLoadsCorrectURL() {
        // given
        let session = URLSessionMockUrl()
        let news = URLSessionProvider(session: session)
        let expectation = XCTestExpectation(description: "Downloading Articles.")
        
        // when
        news.request(type:Artilces.self, service: Period.one) { response in
            XCTAssertEqual(URL(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/1.json?api-key=ownB7L0w3Ak4ttSurYawrl7ccDuN52Tx"), session.lastURL)
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
    }
    
    func testNewsFetchLoadsCorrectURLSeven() {
        // given
        let session = URLSessionMockUrl()
        let news = URLSessionProvider(session: session)
        let expectation = XCTestExpectation(description: "Downloading Articles.")
        
        // when
        news.request(type:Artilces.self, service: Period.seven) { response in
            XCTAssertEqual(URL(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=ownB7L0w3Ak4ttSurYawrl7ccDuN52Tx"), session.lastURL)
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
    }
    
    func testNewsFetchLoadsCorrectURLThirty() {
        // given
        let session = URLSessionMockUrl()
        let news = URLSessionProvider(session: session)
        let expectation = XCTestExpectation(description: "Downloading Articles.")
        
        // when
        news.request(type:Artilces.self, service: Period.thirty) { response in
            XCTAssertEqual(URL(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/30.json?api-key=ownB7L0w3Ak4ttSurYawrl7ccDuN52Tx"), session.lastURL)
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
    }
    

    func testNumberOfTableCells(){
        
        //Given
        let articles = self.createModels()
        
        // When
        sut.processArticles(modelData: articles)
        
        // Then
        XCTAssertEqual(sut.numberOfCells, 1)
    }
    
    func testCellViewModel() {
        //Given
        let articles : Artilces = self.createModels()
        
        // When
        sut.processArticles(modelData: articles)
        
        let article : Article = sut.getCellViewModel(at: IndexPath(row: 0, section: 0))
        let articleOne : Article = article
        let articleTwo : Article = articles.results[0]
        
        // Then
        XCTAssertEqual(articleOne.abstract, articleTwo.abstract)
        
    }
    
    func testSelectedArticle() {
        let articles = self.createModels()
        
        // When
        sut.processArticles(modelData: articles)
        
        sut.articleSelected(indexPath: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertEqual(sut.abstract, articles.results[0].abstract)
        XCTAssertEqual(sut.source, articles.results[0].source)
    }
    
    func createModels() -> Artilces {
        let article = Article(source: "New York Times", publishedDate: "2021-11-08", byline: "By Daniel Victor and Eduardo Medina", type: "Article", title: "Missing Girl Is Rescued After Using Hand Signal From TikTok", abstract: "The girl flashed the hand signal from a car on a Kentucky interstate, the authorities said. It was created as a way for people to indicate that they are at risk of abuse and need help.")
        let articles = Artilces(status: "OK", copyright: "Copyright (c) 2021 The New York Times Company.  All Rights Reserved.", numResults: 20, results: [article])
        return articles
    }
    
}

