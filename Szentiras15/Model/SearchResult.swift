//
//  SearchResut.swift
//  SearchResut
//
//  Created by Gabor Sornyei on 2021. 08. 08..
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchResult = try? newJSONDecoder().decode(SearchResult.self, from: jsonData)

import Foundation

// MARK: - SearchResult
struct SearchResult: Codable {
    var fullTextResult: FullTextResult?
}

extension SearchResult {
    static var empty: SearchResult {
        SearchResult(fullTextResult: FullTextResult(results: [], hitCount: 0))
    }
}

extension SearchResult {
    static func example(of filename: String) -> SearchResult {
        let url = Bundle.main.url(forResource: filename, withExtension: "json")!
        
        do {
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(SearchResult.self, from: data)
            return result
        } catch {
            print("Error in converting file: \(filename).json", error.localizedDescription)
        }
        return SearchResult.empty
    }
}

// MARK: - FullTextResult
struct FullTextResult: Codable {
    var results: [Result]?
    var hitCount: Int?
}

// MARK: - Result
struct Result: Codable {
    var book: Book?
    var translation: Translation?
    var chapters: [String: [Verse]]?
    var verses: [Verse]?
}

// MARK: - Book
struct Book: Codable {
    var number: Int?
    var translationID: Int?
    var name, abbrev, link: String?
    var oldTestament, id: Int?

    enum CodingKeys: String, CodingKey {
        case number
        case translationID = "translation_id"
        case name, abbrev, link
        case oldTestament = "old_testament"
        case id
    }
}

// MARK: - Verse
struct Verse: Codable {
    var chapter: Int?
    var numv, text: String?
}

// MARK: - Translation
struct Translation: Codable {
    var id: Int?
    var name: Name?
    var abbrev: Abbrev?
    var order: Int?
    var denom: Denom?
    var lang: Lang?
    var copyright: String?
    var publisher: Publisher?
    var publisherURL: String?
    var reference: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name, abbrev, order, denom, lang, copyright, publisher
        case publisherURL = "publisher_url"
        case reference
    }
}

enum Abbrev: String, Codable {
    case bd = "BD"
    case kg = "KG"
    case knb = "KNB"
    case ruf = "RUF"
    case stl = "STL"
    case szit = "SZIT"
    case uf = "UF"
}

enum Denom: String, Codable {
    case katolikus = "katolikus"
    case protest??ns = "protest??ns"
}

enum Lang: String, Codable {
    case magyar = "magyar"
}

enum Name: String, Codable {
    case b??k??sDalos??jsz??vets??giSzent??r??s = "B??k??s-Dalos ??jsz??vets??gi Szent??r??s"
    case k??ldiNeovulg??ta = "K??ldi-Neovulg??ta"
    case k??roliG??sp??rRevide??ltFord??t??sa = "K??roli G??sp??r revide??lt ford??t??sa"
    case magyarBibliat??rsulat??jford??t??s??Bibli??ja1990 = "Magyar Bibliat??rsulat ??jford??t??s?? Bibli??ja (1990)"
    case magyarBibliat??rsulat??jford??t??s??Bibli??ja2014 = "Magyar Bibliat??rsulat ??jford??t??s?? Bibli??ja (2014)"
    case simonTam??sL??szl????jsz??vets??gFord??t??sa = "Simon Tam??s L??szl?? ??jsz??vets??g-ford??t??sa"
    case szentIstv??nT??rsulatiBiblia = "Szent Istv??n T??rsulati Biblia"
}

enum Publisher: String, Codable {
    case benc??sKiad?? = "Benc??s Kiad??"
    case katolikusBibliat??rsulat = "Katolikus Bibliat??rsulat"
    case magyarBibliat??rsulat = "Magyar Bibliat??rsulat"
    case szentIstv??nT??rsulat = "Szent Istv??n T??rsulat"
    case theWord = "The Word"
}
