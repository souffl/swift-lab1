//
//  parser.swift
//  lab1
//
//  Created by Екатерина Берендюгина on 18.02.2026.
//
enum ParseError: Error {
    case emptyInput
    case missingValue(flag: String)
    case valueWithoutFlag (value: String)
    
    var errorDescription: String? {
            switch self {
            case .emptyInput:
                return "Пустая команда"
            case .missingValue(let flag):
                return "У флага \(flag) нет значения"
            case .valueWithoutFlag(let value):
                return "Значение без флага: \(value)"
            }
        }
}

func tokenize(_ input: String) -> [String] {
    var tokens: [String] = []
    var current = ""
    var inQuotes = false

    for ch in input {
        if ch == "\"" {
            inQuotes.toggle()
            continue
        }

        if ch.isWhitespace && !inQuotes {
            if !current.isEmpty {
                tokens.append(current)
                current = ""
            }
        } else {
            current.append(ch)
        }
    }

    if !current.isEmpty { tokens.append(current) }
    return tokens
}

func parse(_ tokens: [String]) -> Result<(command: String, arguments: [String: [String]]), ParseError> {
    
    guard let command = tokens.first else {
        return .failure(.emptyInput)
    }
    var arguments = [String: [String]]();
    var i = 1;
    while i < tokens.count {
            let token = tokens[i]
        
            guard token.hasPrefix("-") else {
                return .failure(.valueWithoutFlag(value: token))
            }

            let key = token

            guard i + 1 < tokens.count else {
                return .failure(.missingValue(flag: key))
            }

            let value = tokens[i + 1]

                guard !value.hasPrefix("-") else {
                    return .failure(.missingValue(flag: key))
                }

                arguments[key, default: []].append(value)
                i += 2
    }
    return .success((command, arguments))
}

