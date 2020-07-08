class MazeGenerator: MapGenerator {
  func generate(players: [Player]) -> Map {
    print("Генериране на карта...")

    var mapSize: Int = 0

    repeat {
      print("Моля въведете желания размер на картата (Пример: \"30\"): ")
      if let size = readLine(as: Int.self) {
        mapSize = size
      } else {
        print("Невалиден вход! Моля, опитай пак.")  
      }
    } while mapSize == 0

    

  }
}