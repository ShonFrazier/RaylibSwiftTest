//
//  Main.swift
//  Yokta Beginnings
//
//  Created by Shon on 12/18/24.
//

import AppKit
import Raylib
//import Clay

@main
struct MyApp {
  
  static func makeMenu() -> NSMenu {
    let mainMenu = NSMenu()
    
    let appMenuItem = NSMenuItem()
    mainMenu.addItem(appMenuItem)
    
    let appMenu = NSMenu()
    appMenuItem.submenu = appMenu
    
    let quitMenuItem = NSMenuItem(
      title: "Quit",
      action: #selector(NSApplication.terminate(_:)),
      keyEquivalent: "q"
    )
    appMenu.addItem(quitMenuItem)
    
    
    return mainMenu
  }
  
  static let fps: Double = 120;
  
  static func main() {
    let app = NSApplication.shared
    app.mainMenu = makeMenu()
    
    let frameTime = Int((1.0 / fps) * 1_000_000.0);
    print("frame time in µs: \(frameTime)")
    
    let game = Game(nil, FLAG_WINDOW_RESIZABLE)
    let timer = DispatchSource.makeTimerSource()
    timer.schedule(deadline: .now(), repeating:.microseconds(frameTime))
    timer.setEventHandler {
      DispatchQueue.main.sync {
        if game.isRunning && !WindowShouldClose() {
          game.step()
        } else {
          timer.cancel()
          app.stop(timer)
        }
      }
    }
    timer.resume()
    
    app.run()
  }
}
