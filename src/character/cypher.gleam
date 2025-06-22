pub type Cypher {
  Cypher(name: String, description: String, level: Int)
}

pub fn new() -> Cypher {
  Cypher("", "", 1)
}
