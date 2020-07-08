protocol Hero {
  var race: String {get}

  var energy: Int {get set}
  var lifePoitns: Int {get set}

  var weapon: Weapon? {get set}
  var armor: Armor? {get set}
}