var mapVis = MapVisualizer()

class DefaultMapTile: MapTile {
    var type: MapTileType
    var state: String
    
    init(type: MapTileType) {
        self.type = type
        state = ""
    }
}



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
  var position: (Int, Int) = (2, 2)
}

var p = DefaultPlayer()

var m = DefaultMap(players: [p])

mapVis.render(map: m)