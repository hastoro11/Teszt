//
//  WebService.swift
//  WebService
//
//  Created by Gabor Sornyei on 2021. 08. 08..
//

import Foundation

struct WebService {
    
    static var shared: WebService = WebService()
    
    private init() {}
    
    func fetch(book: String, chapter: Int, translation: String = "RUF") async throws -> Idezet {
        guard let url = buildURLForIdezet(book: book, chapter: chapter, translation: translation) else {
            throw SzentirasError.badURL( buildURLForIdezet(book: book, chapter: chapter, translation: translation)?.path ?? "")
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let resp = response as? HTTPURLResponse, resp.statusCode != 200 {
            throw SzentirasError.serverError
        }
        do {
            let idezet = try JSONDecoder().decode(Idezet.self, from: data)
            if idezet.valasz.versek.isEmpty {
                throw SzentirasError.badInput
            }
            return idezet
        } catch {
            if let _ = error as? SzentirasError {
                throw SzentirasError.badInput
            }
            print("Error decoding response:", error)
            throw SzentirasError.decodingError
        }
    }
    
    func buildURLForIdezet(book: String, chapter: Int, translation: String = "RUF") -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "szentiras.hu"
        urlComponents.path = "/api/idezet/\(book)\(chapter)/\(translation)".removingPercentEncoding ?? "/api/idezet/\(book)\(chapter)/\(translation)"
        
        return urlComponents.url
    }
}
