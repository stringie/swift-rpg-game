struct DefaultHero: Hero {
  var race: String  = "Random Race"

  var energy: Int = 5
  var lifePoitns: Int = 7

  var weapon: Weapon?  = nil
  var armor: Armor? = nil
}

class DefaultPlayer: Player {
  var name: String = "Default Player"
  var hero: Hero = DefaultHero()
  var isAlive: Bool  = true
}

var p = DefaultPlayer()
var p2 = DefaultPlayer()
p2.name = "Two"

var mapVis = MapVisualizer()
var g = MazeGenerator()
var m = g.generate(players: [p, p2])

var command: String = "exit"
repeat {
  mapVis.render(map: m)
  print()

  var moves = m.availableMoves(player: p)

  var i: Int = 0
  for move in moves {
    print("[\(i)]" + move.friendlyCommandName)
    i += 1
  }

  print("\nEnter command index or type \"exit\" to end game: ")
  if let c = readLine() {
    command = c

    if c != "exit" {
      let index = Int(c)!
      m.move(player: p, move: moves[index])
    }
  }
} while command != "exit"