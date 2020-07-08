protocol Map {
  init(players: [Player])
  var players: [Player] {get}
  var maze: [[MapTile]] {get}

  func availableMoves(player: Player) -> [PlayerMove]
  func move(player: Player, move: PlayerMove)
}