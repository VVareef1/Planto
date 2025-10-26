//
//  Plant.swift
//  Planto
//
//  Created by Wareef Saeed Alzahrani on 30/04/1447 AH.
//
import SwiftUI
import Combine

struct Plant: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var room: String
    var light: String
    var waterAmount: String
    var isWatered: Bool = false
}
