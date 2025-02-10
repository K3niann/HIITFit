//
//  HIITFitApp.swift
//  HIITFit
//
//  Created by Keniann Sierra on 1/22/25.
//

import SwiftUI

@main
struct HIITFitApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
            .onAppear {
             print(URL.documentsDirectory)
            }
    }
  }
}
