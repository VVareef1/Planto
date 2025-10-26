//
//  ViewModel.swift
//  Planto
//
//  Created by Wareef Saeed Alzahrani on 30/04/1447 AH.
//
import SwiftUI
import Combine

final class PlantStore: ObservableObject {
    @Published var plants: [Plant] = []
}
