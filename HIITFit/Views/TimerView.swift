//
//  TimerView.swift
//  HIITFit
//
//  Created by Keniann Sierra on 2/1/25.
//

import SwiftUI

struct CountdownView: View {
  let date: Date
  @Binding var timeRemaining: Int
  let size: Double

  var body: some View {
    Text("\(timeRemaining)") //5
      .font(.system(size: size, design: .rounded))
      .padding()
      .onChange(of: date) { _ in //6
        timeRemaining -= 1
      }
  }
}

struct TimerView: View {
  @State private var timeRemaining: Int = 3 //1
  @Binding var timerDone: Bool //2
  let size: Double

  var body: some View {
    TimelineView( //3
      .animation(
        minimumInterval: 1.0,
        paused: timeRemaining <= 0)) { context in
          CountdownView( //4
            date: context.date,
            timeRemaining: $timeRemaining,
            size: size)
    }
    .onChange(of: timeRemaining) { _ in
      if timeRemaining < 1 {
        timerDone = true //7
      }
    }
  }
}

struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView(timerDone: .constant(false), size: 90)
  }
}
