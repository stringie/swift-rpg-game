class DefaultPlayerMove: PlayerMove {
  var direction: MapMoveDirection 
  var friendlyCommandName: String  

  init(direction: MapMoveDirection, friendlyCommandName: String) {
    self.direction = direction
    self.friendlyCommandName = friendlyCommandName
  }
}

class DefaultMap: Map {
  var players: [Player]
  var maze: [[MapTile]] = []
  var playerPositions: [(Int, Int)] = []
  var teleportPositions: [(Int, Int)] = []

  required init(players: [Player]) {
    self.players = players
  }

  func availableMoves(player: Player) -> [PlayerMove] { 
    let index: Int = self.findPlayerIndex(player: player)
    let pos: (Int, Int) = self.playerPositions[index]

    var moves: [PlayerMove] = []

    for i in [-1, 0, 1] {
      for j in [-1, 0, 1] {
        if abs(i) != abs(j) {
          var tile: MapTile = self.maze[pos.0 + i][pos.1 + j]

          if  tile.type != MapTileType.rock, tile.type != MapTileType.wall {
            let direction: MapMoveDirection = self.getDirection(i: i, j: j)
            let directionString: String = self.getDirectionString(direction: direction)

            if tile.type == MapTileType.chest, tile.state != "opened" {
              moves.append(DefaultPlayerMove(direction: direction, friendlyCommandName: "\(directionString): open chest"))
            } else if tile.type == MapTileType.teleport {
              moves.append(DefaultPlayerMove(direction: direction, friendlyCommandName: "\(directionString): teleport"))
            } else if tile.type == MapTileType.player, tile.state != "dead" {
              moves.append(DefaultPlayerMove(direction: direction, friendlyCommandName: "\(directionString): fight"))
            } else if tile.type == MapTileType.empty {
              moves.append(DefaultPlayerMove(direction: direction, friendlyCommandName: "\(directionString): move"))
            }
          }
        }
      }
    }

    return moves
  }

  func move(player: Player, move: PlayerMove) {
    let index: Int = self.findPlayerIndex(player: player)
    let movePos: (Int, Int) = self.getMovePos(direction: move.direction, playerPosition: self.playerPositions[index])
    
    if maze[movePos.0][movePos.1].type == MapTileType.empty {
      // simply move to the empty position
      maze[self.playerPositions[index].0][self.playerPositions[index].1].type = MapTileType.empty
      self.playerPositions[index] = movePos
      maze[movePos.0][movePos.1].type = MapTileType.player
    } else if maze[movePos.0][movePos.1].type == MapTileType.chest {
      // the chest reward has been handled by the equipment module before this function, so we just change the
      // chest state to opened so it is not used again
      maze[movePos.0][movePos.1].state = "opened"
    } else if maze[movePos.0][movePos.1].type == MapTileType.player {
      // fight has been handled by the game class before this function, so if we have reached here that means
      // current player is alive and has killed the player sitting on this position, so we make them dead
      maze[movePos.0][movePos.1].state = "dead"
    } else if maze[movePos.0][movePos.1].type == MapTileType.teleport {
      // the teleporter in this implementation of the map module functions as a one-time-use device, so once the
      // player enters and exits the current teleporter, both devices disappear and become and empty tile
      maze[movePos.0][movePos.1].type = MapTileType.empty
      maze[self.playerPositions[index].0][self.playerPositions[index].1].type = MapTileType.empty
      let otherTeleporter = self.findTeleporter(currentPosition: movePos)
      self.playerPositions[index] = otherTeleporter
      maze[otherTeleporter.0][otherTeleporter.1].type = MapTileType.player
      self.teleportPositions = []
    }
  }

  func setMazeDetails(maze: [[MapTile]], playerPositions: [(Int, Int)], teleportPositions: [(Int, Int)]) {
    self.maze = maze
    self.playerPositions = playerPositions
    self.teleportPositions = teleportPositions
  }

  private func findPlayerIndex(player: Player) -> Int {
    var i: Int = 0
    for p in self.players {
      if p.name == player.name {
        break
      }
      i += 1
    }

    return i
  }

  private func getDirection(i: Int, j: Int) -> MapMoveDirection {
    if i == 1, j == 0 {
      return MapMoveDirection.down
    }
    if i == -1, j == 0 {
      return MapMoveDirection.up
    }
    if i == 0, j == 1 {
      return MapMoveDirection.right
    }
    if i == 0, j == -1 {
      return MapMoveDirection.left
    }

    return MapMoveDirection.up
  }

  private func getDirectionString(direction: MapMoveDirection) -> String {
    switch direction {
      case MapMoveDirection.up: return "up"
      case MapMoveDirection.down: return "down"
      case MapMoveDirection.left: return "left"
      case MapMoveDirection.right: return "right"
    }
  }

  private func getMovePos(direction: MapMoveDirection, playerPosition: (Int, Int)) -> (Int, Int) {
    switch direction {
      case MapMoveDirection.up: return (playerPosition.0 - 1, playerPosition.1)
      case MapMoveDirection.down: return (playerPosition.0 + 1, playerPosition.1)
      case MapMoveDirection.left: return (playerPosition.0, playerPosition.1 - 1)
      case MapMoveDirection.right: return (playerPosition.0, playerPosition.1 + 1)
    }
  }

  private func findTeleporter(currentPosition: (Int, Int)) -> (Int, Int) {
    if self.teleportPositions[0].0 == currentPosition.0, self.teleportPositions[0].1 == currentPosition.1 {
      return self.teleportPositions[1]
    } else {
      return self.teleportPositions[0]
    }
  }
}