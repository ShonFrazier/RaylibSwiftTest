//
//  Main.swift
//  Yokta Beginnings
//
//  Created by Shon on 12/18/24.
//

import AppKit


let RAYWHITE = Color(r: 245, g: 245, b: 245, a: 255)
let BLACK = Color(r: 0, g: 0, b: 0, a: 0)

@main
struct MyApp {
  static func main() {
    // Create and set up the application instance
    let app = NSApplication.shared
    
    // Create and set up the menu bar
    let mainMenu = NSMenu()
    let appMenuItem = NSMenuItem()
    mainMenu.addItem(appMenuItem)
    app.mainMenu = mainMenu
    
    let appMenu = NSMenu()
    let quitMenuItem = NSMenuItem(
      title: "Quit",
      action: #selector(NSApplication.terminate(_:)),
      keyEquivalent: "q"
    )
    appMenu.addItem(quitMenuItem)
    appMenuItem.submenu = appMenu
    
    // Create and configure the main window
    let window = NSWindow(
      contentRect: NSRect(x: 100, y: 100, width: 800, height: 600),
      styleMask: [.titled, .closable, .miniaturizable, .resizable],
      backing: .buffered,
      defer: false
    )
    window.title = "My App"
    window.makeKeyAndOrderFront(nil)
    
    InitWindow(800, 600, "Raylib Swift macOS Example")
    
    let timer = DispatchSource.makeTimerSource()
    timer.schedule(deadline: .now(), repeating:.microseconds(16667))
    timer.setEventHandler {
      if !WindowShouldClose() {
        BeginDrawing()
        ClearBackground(RAYWHITE)
        
        // Your drawing code here
        DrawText("Hello, Raylib on macOS!", 190, 200, 20, BLACK)
        
        EndDrawing()
      } else {
        timer.cancel()
        app.stop(timer)
      }
      
      CloseWindow()
    }
    timer.resume()
    
    // Run the event loop
    app.run()
  }
}
