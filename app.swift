//
//  app.swift
//  lab1
//
//  Created by Екатерина Берендюгина on 18.02.2026.
//
import Foundation

class ShelfApp {
    init (_ shelf: BookShelfProtocol)
    {
        self.shelf = shelf
    }
    
    private func handleAdd(flags: [String: [String]])
    {
            func first(_ key: String) -> String? {
                flags[key]?.first
            }

            guard let author = first("-a"), !author.isEmpty else {
                print("Ошибка: нужен автор (-a)")
                return
            }
        
            guard let title = first("-t"), !title.isEmpty else {
                print("Ошибка: нужен заголовок (-t)")
                return
            }
        
            guard let genreStr = first("-g"),
                  let genre = Genre(rawValue: genreStr) else {
                print("Ошибка: некорректный жанр")
                return
            }

            var yearValue: Int? = nil
            if let yearStr = first("-y") {
                guard let y = Int(yearStr) else {
                    print("Ошибка: год должен быть числом")
                    return
                }
                yearValue = y
            }

            let tags = flags["-tag"] ?? []

            let book = Book(
                id: UUID(),
                title: title,
                author: author,
                genre: genre,
                year: yearValue,
                tags: tags
            )

        switch self.shelf.add(book) {
            case .success:
                print("Книга добавлена: \(title)")
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
            }
    }
    
    private func handleSearch(flags: [String: [String]])
    {
        var query: [SearchQuery] = []
        if let author = flags["-a"]?.first {
            query.append(.author(author))
        }
        if let title = flags["-t"]?.first {
            query.append(.title(title))
        }
        if let genreStr = flags["-g"]?.first, let genre = Genre(rawValue: genreStr)
        {
            query.append(.genre(genre))
        }
       
        if let yearString = flags["-y"]?.first, let year = Int(yearString) {
            query.append(.year(year))
        }
        
        printBooks(self.shelf.search(query))
    }
    
    private func printBooks(_ books: [Book])
    {
        if books.isEmpty { print("Пусто") }
        else {
            for b in books {
                print("- \(b.title) — \(b.author) [\(b.genre)] \(b.year.map(String.init) ?? "") id=\(b.id)")
            }
        }
    }
    
    func start(){
        while true {
            print("> ", terminator: "")
            guard let line = readLine() else { break }
            let tokens = tokenize(line)
            let command: String
            let flags: [String: [String]]
            switch parse(tokens) {
            case .success(let parsed):
                command = parsed.command
                flags = parsed.arguments

            case .failure(let err):
                print(err.errorDescription)
                continue
            }
            
            switch command {
            case "help":
                print("""
                Команды:
                  add -a "author" -t "title" -g genre [-y year] [-tag tag]...
                  list
                  remove -id UUID
                  search [-a "author] [-t "title"] [-g genre] [-y year] [-tag tag]
                  exit
                Пример:
                  add -a "Dostoevsky" -t "Crime and Punishment" -g classic -y 1866 -tag philosophy
                """)

            case "add":
                handleAdd(flags: flags)
                
            case "list":
                let all = shelf.list()
                printBooks(all)

            case "remove":
                guard let idStr = flags["-id"]?.first, let id = UUID(uuidString: idStr) else {
                    print("Ошибка: remove -id UUID")
                    break
                }
                switch shelf.remove(id: id) {
                case .success(let removed): print("Удалено: \(removed.title)")
                case .failure(let e): print("Ошибка: \(e.localizedDescription)")
                }

            case "exit", "quit":
                return
            
            case "search":
                handleSearch(flags: flags)

            default:
                print("Неизвестная команда. Напиши: help")
            }
        }
    }
    var shelf: BookShelfProtocol
    
}
