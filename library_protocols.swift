//
//  library_protocols.swift
//  lab1
//
//  Created by Екатерина Берендюгина on 18.02.2026.
//
import Foundation

protocol BookShelfProtocol {
    func add(_ book: Book) -> Result<Void, LibraryError>
    func remove(id: UUID) -> Result <Book, LibraryError>
    func list() -> [Book]
    func search(_ query: [SearchQuery]) -> [Book]
}

enum SearchQuery {
    case title(String)
    case author(String)
    case genre(Genre)
    case tag(String)
    case year(Int)
    
}

enum LibraryError: Error, LocalizedError {
    case emptyTitle
    case emptyAuthor
    case invalidYear(Int)
    case notFound(id: UUID)
    case duplicateId(UUID)

    var errorDescription: String? {
        switch self {
        case .emptyTitle: return "Название не может быть пустым"
        case .emptyAuthor: return "Автор не может быть пустым"
        case .invalidYear(let y): return "Некорректный год: \(y)"
        case .notFound(let id): return "Книга с id \(id) не найдена"
        case .duplicateId(let id): return "Книга с id \(id) уже существует"
        }
    }
}


