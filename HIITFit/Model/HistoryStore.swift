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

class HistoryStore: ObservableObject {
    @Published var exerciseDays: [ExerciseDay] = []
    @Published var loadingError = false
    
    enum FileError: Error {
     case loadFailure
     case saveFailure
    }

  init() {
    #if DEBUG
   //createDevData()
    #endif
      do {
       try load()
      } catch {
        loadingError = true
      }
  }
    
    var dataURL: URL {
     URL.documentsDirectory
     .appendingPathComponent("history.plist")
    }
    
    
    func load() throws {
        guard let data = try? Data(contentsOf: dataURL) else {
         return
        }
     do {
     // 1
     // 2
     let plistData = try PropertyListSerialization.propertyList(
     from: data,
     options: [],
     format: nil)
     // 3
     let convertedPlistData = plistData as? [[Any]] ?? []
     // 4
     exerciseDays = convertedPlistData.map {
     ExerciseDay(
     date: $0[1] as? Date ?? Date(),
     exercises: $0[2] as? [String] ?? [])
     }
     } catch {
     throw FileError.loadFailure
     }
    }
    
    
    func addDoneExercise(_ exerciseName: String) {
     let today = Date()
        if let firstDate = exerciseDays.first?.date,
         today.isSameDay(as: firstDate) { // 1
     exerciseDays[0].exercises.append(exerciseName)
     } else {
     exerciseDays.insert( // 2
     ExerciseDay(date: today, exercises: [exerciseName]),
     at: 0)
     }
        do {
         try save()
        } catch {
         fatalError(error.localizedDescription)
        }
    }
    
    func save() throws {
        let plistData = exerciseDays.map {
         [$0.id.uuidString, $0.date, $0.exercises]
        }
        do {// 1
            let data = try PropertyListSerialization.data(
            fromPropertyList: plistData,
            format: .binary,
            options: .zero)
            // 2
            try data.write(to: dataURL, options: .atomic)
           } catch {
            // 3
            throw FileError.saveFailure
           }
    }
    
}
