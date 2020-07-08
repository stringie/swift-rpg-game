class DefaultMap : Map {
  var players: [Player]
  var maze: [[MapTile]]

  required init(players: [Player]) {
    self.players = players
  }

  func availableMoves(player: Player) -> [PlayerMove] { 
    return []
  }

  func move(player: Player, move: PlayerMove) {
  }
}