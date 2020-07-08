protocol Player {
  var name: String {get set}
  var hero: Hero {get set}
  var isAlive: Bool {get set}
  var position: (Int, Int) {get set}
}