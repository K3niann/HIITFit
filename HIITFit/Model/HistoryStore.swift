//
//  HistoryStore.swift
//  HIITFit
//
//  Created by Keniann Sierra on 1/26/25.
//

import Foundation

struct ExerciseDay: Identifiable {
  let id = UUID()
  let date: Date
  var exercises: [String] = []
}

struct HistoryStore {
  var exerciseDays: [ExerciseDay] = []

  init() {
    #if DEBUG
    createDevData()
    #endif
  }

  mutating func addDoneExercise(_ exerciseName: String) {
    let today = Date()
    if today.isSameDay(as: exerciseDays[0].date) {
      print("Adding \(exerciseName)")
      exerciseDays[0].exercises.append(exerciseName)
    } else {
      exerciseDays.insert(
        ExerciseDay(date: today, exercises: [exerciseName]),
        at: 0)
    }
  }
}
