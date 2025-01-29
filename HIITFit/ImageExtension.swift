//
//  ImageExtension.swift
//  HIITFit
//
//  Created by Keniann Sierra on 1/26/25.
//

import SwiftUI

extension Image {
  func resizedToFill(width: CGFloat, height: CGFloat) -> some View {
    self
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: width, height: height)
  }
}
