//
//  WelcomeView.swift
//  HIITFit
//
//  Created by Keniann Sierra on 1/22/25.
//

import SwiftUI

struct WelcomeView: View {
  @State private var showHistory = false
  @Binding var selectedTab: Int

  var body: some View {
    ZStack {
      VStack {
        HeaderView(selectedTab: $selectedTab, titleText: "Welcome")
        Spacer()
        Button("History") {
          showHistory.toggle()
        }
        .sheet(isPresented: $showHistory) {
          HistoryView(showHistory: $showHistory)
        }
        .padding(.bottom)
      }

      VStack {
        HStack(alignment: .bottom) {
          VStack(alignment: .leading) {
            Text("Get fit")
              .font(.largeTitle)
            Text("with high intensity interval training")
              .font(.headline)
          }
          Image("step-up")
            .clipShape(Circle())
        }

        Button(action: { selectedTab = 0 }) {
          Text("Get Started")
          Image(systemName: "arrow.right.circle")
        }
        .font(.title2)
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 20)
          .stroke(Color.gray, lineWidth: 2))
      }
    }
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView(selectedTab: .constant(9))
  }
}
