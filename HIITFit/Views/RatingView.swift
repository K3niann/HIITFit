//
//  RatingView.swift
//  HIITFit
//
//  Created by Keniann Sierra on 1/26/25.
//

import SwiftUI

struct RatingView: View {
    
    let exerciseIndex: Int
    @AppStorage("ratings") private var ratings = ""
    @State private var rating = 0
    let maximumRating = 5  // 2

    let onColor = Color.red  // 3
    let offColor = Color.gray
    
    // 1
    init(exerciseIndex: Int) {
    self.exerciseIndex = exerciseIndex
    // 2
    let desiredLength = Exercise.exercises.count
    if ratings.count < desiredLength {
    // 3
    ratings = ratings.padding(
    toLength: desiredLength,
    withPad: "0",
    startingAt: 0)
        }
    }

    fileprivate func convertRating() {
        // 2
        let index = ratings.index(
            ratings.startIndex,
            offsetBy: exerciseIndex)
        // 3
        let character = ratings[index]
        // 4
        rating = character.wholeNumberValue ?? 0
    }
    
    var body: some View {
    HStack {
      ForEach(1 ..< maximumRating + 1, id: \.self) { index in
        Image(systemName: "waveform.path.ecg")
          // 1
          .onAppear {
              convertRating()
          }
          .onChange(of: ratings) { _ in
              convertRating()
               }
          .foregroundColor(
            index > rating ? offColor : onColor)  // 4
          .onTapGesture {  // 5
              updateRating(index: index)
           
          }
      }
    }
    .font(.largeTitle)
  }
    
    func updateRating(index: Int) {
     rating = index
     let index = ratings.index(
     ratings.startIndex,
     offsetBy: exerciseIndex)
     ratings.replaceSubrange(index...index, with: String(rating))
    }
}

struct RatingView_Previews: PreviewProvider {
  @AppStorage("ratings") static var ratings: String?
  static var previews: some View {
      ratings = nil
      return RatingView(exerciseIndex: 0)
          .previewLayout(.sizeThatFits)
  }
}
