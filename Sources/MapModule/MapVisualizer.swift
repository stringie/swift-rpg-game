class MapVisualizer: MapRenderer {
  public func render(map: Map) {
    for row in map.maze {
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
    }
  }
}