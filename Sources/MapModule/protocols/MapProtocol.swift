protocol Map {
  init(players: [Player])
  var players: [Player] {get}
  var maze: [[MapTile]] {get}
  var playerPositions: [(Int, Int)] {get}

  func availableMoves(player: Player) -> [PlayerMove]
  func move(player: Player, move: PlayerMove)
}