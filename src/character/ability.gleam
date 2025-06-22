import gleam/option

pub type PoolCost {
  Might(Int)
  Speed(Int)
  Intellect(Int)
}

pub type Ability {
  Ability(name: String, description: String, cost: option.Option(PoolCost))
}

pub fn new() -> Ability {
  Ability("", "", option.None)
}
