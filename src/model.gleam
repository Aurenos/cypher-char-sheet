import character/core as char

pub type Model {
  Model(character: char.Character)
}

pub fn new() -> Model {
  Model(character: char.new())
}
