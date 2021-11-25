//
//  Article.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 25/11/21.
//

/** Model Class to hold the data in a data structre which conforms to Codable protocol */

import Foundation

// MARK: - Welcome
struct Artilces: Codable {
    let status, copyright: String
    let numResults: Int
    let results: [Article]

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - Result
struct Article: Codable {

    let source: String
    let publishedDate: String
    let byline: String
    let type: String
    let title, abstract: String

    enum CodingKeys: String, CodingKey {
        case source
        case publishedDate = "published_date"
        case byline, type, title, abstract
 
    }
}


