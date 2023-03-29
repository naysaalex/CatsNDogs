//
//  CatsNDogsV1App.swift
//  CatsNDogsV1
//
//  Created by cashamirica on 3/27/23.
//

import SwiftUI

@main
struct CatsNDogsV1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(model: AnimalModel())
        }
    }
}
