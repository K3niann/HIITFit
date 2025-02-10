//
//  ExerciseView.swift
//  HIITFit
//
//  Created by Keniann Sierra on 1/22/25.
//

import SwiftUI

struct ExerciseView: View {
    
    @EnvironmentObject var history: HistoryStore
    
    @State private var showHistory = false
    @State private var showSuccess = false
    @State private var timerDone = false
    @State private var showTimer = false
    
    @Binding var selectedTab: Int
  let index: Int

  var exercise: Exercise {
    Exercise.exercises[index]
  }
  var lastExercise: Bool {
    index + 1 == Exercise.exercises.count
  }

  var startButton: some View {
      Button("Start Exercise") {
       showTimer.toggle()
      }
  }

  var doneButton: some View {
    Button("Done") {
        history.addDoneExercise(Exercise.exercises[index].exerciseName)
        timerDone = false
        showTimer.toggle()
      if lastExercise {
        showSuccess.toggle()
      } else {
        selectedTab += 1
      }
    }
  }

  var body: some View {
    GeometryReader { geometry in
      VStack {
        HeaderView(
          selectedTab: $selectedTab,
          titleText: Exercise.exercises[index].exerciseName)
          .padding(.bottom)

        VideoPlayerView(videoName: exercise.videoName)
          .frame(height: geometry.size.height * 0.45)

        HStack(spacing: 150) {
          startButton
          doneButton
            .disabled(!timerDone)
            .sheet(isPresented: $showSuccess) {
              SuccessView(selectedTab: $selectedTab)
                .presentationDetents([.medium, .large])
            }
        }
        .font(.title3)
        .padding()

          if showTimer {
           TimerView(
           timerDone: $timerDone,
           size: geometry.size.height * 0.07
           )
          }
          
        Spacer()
          RatingView(exerciseIndex: index)
          .padding()

        Button("History") {
          showHistory.toggle()
        }
        .sheet(isPresented: $showHistory) {
          HistoryView(showHistory: $showHistory)
        }
          .padding(.bottom)
      }
    }
  }
}

struct ExerciseView_Previews: PreviewProvider {
  static var previews: some View {
      ExerciseView(selectedTab: .constant(0), index: 0)
       .environmentObject(HistoryStore())
  }
}
