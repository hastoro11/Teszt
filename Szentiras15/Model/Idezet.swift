//
//  Idezet.swift
//  Idezet
//
//  Created by Gabor Sornyei on 2021. 08. 08..
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let idezet = try? newJSONDecoder().decode(Idezet.self, from: jsonData)

import Foundation

// MARK: - Idezet
struct Idezet: Codable {
    var keres: Keres
    var valasz: Valasz
}

extension Idezet {
    static var empty: Idezet {
        Idezet(keres: Keres(feladat: "idezet", hivatkozas: "Róm 16", forma: "json"), valasz: Valasz(verses: [], forditas: Forditas(nev: "Magyar Bibliatársulat újfordítású Bibliája (2014)", rov: "RUF")))
    }
}

extension Idezet {
    static func example(of filename: String) -> Idezet {
        let url = Bundle.main.url(forResource: filename, withExtension: "json")!
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode(Idezet.self, from: data)
        } catch {
            print("Error in converting file: \(filename).json", error.localizedDescription)
        }
        return Idezet.empty
    }
}

// MARK: - Keres
struct Keres: Codable {
    var feladat, hivatkozas, forma: String
}

// MARK: - Valasz
struct Valasz: Codable {
    var verses: [Versek]?
    var forditas: Forditas
    
    enum CodingKeys: String, CodingKey {
        case verses = "versek"
        case forditas
    }
}

extension Valasz {
    var versek: [Versek] {
        verses ?? []
    }
}

// MARK: - Forditas
struct Forditas: Codable {
    var nev, rov: String
}

// MARK: - Versek
struct Versek: Codable {
    var szoveg: String
    var hely: Hely
}

// MARK: - Hely
struct Hely: Codable {
    var gepi: Int
    var szep: String
}

