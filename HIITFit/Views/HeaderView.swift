//
//  HeaderView.swift
//  HIITFit
//
//  Created by Keniann Sierra on 1/26/25.
//


import SwiftUI

struct HeaderView: View {
  @Binding var selectedTab: Int  // 1
  let titleText: String

  var body: some View {
    VStack {
      Text(titleText)
        .font(.largeTitle)
      HStack {  // 2
        ForEach(Exercise.exercises.indices, id: \.self) { index in  // 3
          let fill = index == selectedTab ? ".fill" : ""
          Image(systemName: "\(index + 1).circle\(fill)")  // 4
                .onTapGesture {
                 selectedTab = index
                }
        }
      }
      .font(.title2)
    }
  }
}

struct HeaderView_Previews: PreviewProvider {
  static var previews: some View {
    HeaderView(selectedTab: .constant(0), titleText: "Squat")
      .previewLayout(.sizeThatFits)
  }
}
