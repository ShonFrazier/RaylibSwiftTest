//
//  ContentView.swift
//  Yokta Beginnings
//
//  Created by Shon on 12/18/24.
//


import SwiftUI

// Wrap NSViewController in a SwiftUI View
struct RaylibView: NSViewControllerRepresentable {
  func makeNSViewController(context: Context) -> RaylibViewController {
    return RaylibViewController()
  }
  
  func updateNSViewController(_ nsViewController: RaylibViewController, context: Context) {
    // Update logic if needed
  }
}

struct ContentView: View {
  var body: some View {
#if RAY
    RaylibView()
#else
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
    }
    .padding()
#endif
  }
}

#Preview {
  ContentView()
}
