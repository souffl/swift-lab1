//
//  book_shelve.swift
//  lab1
//
//  Created by Екатерина Берендюгина on 18.02.2026.
//
import Foundation

class BookShelve: BookShelfProtocol {
    func add(_ book: Book) -> Result<Void, LibraryError> {
        if books.contains(book) {
            return .failure(.duplicateId(book.id))
        }
        books.insert(book)
        return .success(())
    }
    
    func remove(id: UUID) -> Result<Book, LibraryError> {
        guard let book = books.first(where: { $0.id == id }) else {
                return .failure(.notFound(id: id))
            }
        books.remove(book)
        return .success(book)
    }
    
    func list() -> [Book] {
        return Array(books)
    }
    
    func search(_ query: [SearchQuery]) -> [Book] {
        var result = Array(books)
        for q in query {
            switch q{
            case .title(let s):
                let normalized = normalize(s)
                result = result.filter {normalize($0.title).contains(normalized)}
            case .author(let s):
                let normalized = normalize(s)
                result = result.filter {normalize($0.author).contains(normalized)}
            case .genre(let g) :
                result = result.filter { $0.genre == g }
            case .tag(let t):
                let normalized = normalize(t)
                result = result.filter { $0.tags.contains(where: { normalize($0) == normalized })}
            case .year(let y):
                result = result.filter { $0.year == y}
            }
        }
        return result
    }
    
    private func normalize(_ s: String) -> String {
        return s.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var books: Set<Book> = []
    
    
}
