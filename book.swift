//
//  book.swift
//  lab1
//
//  Created by Екатерина Берендюгина on 18.02.2026.
//
import Foundation

enum Genre: String, CaseIterable, Codable, Equatable {
    case fiction, nonFiction, mystery, sciFi, biography, fantasy
}


struct Book: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let author: String
    let year: Int?
    let genre: Genre
    var tags: [String]
    
    
    init (id: UUID, title: String, author: String, genre: Genre, year: Int?, tags: [String])
    {
        self.id = id
        self.title = title.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        self.author = author.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        self.year = year
        self.genre = genre
        self.tags = tags
    }
    
    mutating func addTag (tag: String) -> Void
    {
        self.tags.append(tag.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
    }
}

extension Book : Equatable{
    static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
}
