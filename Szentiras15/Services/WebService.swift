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
        let url = buildURLForIdezet(book: book, chapter: chapter, translation: translation)
        
        let idezet: Idezet = try await fetch(url: url)
        
        return idezet
    }
    
    func search(for search: String) async throws -> SearchResult {
        let url = buildURLForSearch(search)
    
        let result: SearchResult = try await fetch(url: url)
        
        return result
    }
    
    private func fetch<T: Codable>(url: URL?) async throws -> T {
        guard let builtURL = url else {
            throw SzentirasError.badURL(url?.path ?? "")
        }
        
        let (data, response) = try await URLSession.shared.data(from: builtURL)
        if let resp = response as? HTTPURLResponse, resp.statusCode != 200 {
            throw SzentirasError.serverError
        }
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            if let _ = error as? SzentirasError {
                throw SzentirasError.badInput
            }
            print("Error decoding response:", error)
            throw SzentirasError.decodingError
        }
    }
    
    private func buildURLForSearch(_ search: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "szentiras.hu"
        urlComponents.path = "/api/search/\(search)".removingPercentEncoding ?? "/api/search/\(search)"
        
        return urlComponents.url
    }
    
    private func buildURLForIdezet(book: String, chapter: Int, translation: String = "RUF") -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "szentiras.hu"
        urlComponents.path = "/api/idezet/\(book)\(chapter)/\(translation)".removingPercentEncoding ?? "/api/idezet/\(book)\(chapter)/\(translation)"
        
        return urlComponents.url
    }
}
