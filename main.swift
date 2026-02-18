//
//  main.swift
//  lab1
//
//  Created by Екатерина Берендюгина on 18.02.2026.
//
import Foundation

var shelf: BookShelfProtocol = BookShelve()

var app = ShelfApp(shelf)

app.start()

