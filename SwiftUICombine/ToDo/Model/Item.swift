//
//  Item.swift
//  ToDo
//
//  Created by giora krasilshchik on 19/10/2020.
//

import Foundation

struct Item: Identifiable {
    var id = UUID()
    let title: String
    var completed = false
}
