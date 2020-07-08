class MapVisualizer: MapRenderer {
  public func render(map: Map) {
    let xAxis = Array(0 ..< map.maze.count).map({"\u{001B}[0;3\($0 % 2 + 3)m\($0 < 10 ? " " : "")" + String($0)}).joined(separator: "")
    print("  " + xAxis)
    var i: Int = 0
    for row in map.maze {
      print("\u{001B}[0;3\(i % 2 + 3)m\(i < 10 ? " " : "")" + String(i), terminator:"")
      for tile in row {
        switch tile.type {
          case MapTileType.empty: print("⛆", terminator: " ")
          case MapTileType.chest: print("🎁", terminator: " ")
          case MapTileType.rock: print("🗿", terminator: " ")
          case MapTileType.player: print("🧍", terminator: " ")
          case MapTileType.teleport: print("🕳️", terminator: " ")
          case MapTileType.wall: print("🧱", terminator: " ")
        }
      }
      print("")
      i += 1
    }

    print("\u{001B}[0;33m\nLEGEND:\n players: 🧍 , teleporters: 🕳️ , walls: 🧱 , rocks: 🗿 , chests: 🎁 , empty: ⛆")
    var player: Int = 1
    for playerPosition in map.playerPositions {
      print(" Player #\(player) position is (x: \(playerPosition.0), y: \(playerPosition.1))")
      player += 1
    }
  }
}