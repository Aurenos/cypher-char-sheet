import gleam/option.{type Option}

pub type Character {
  Character(
    name: String,
    descriptor: String,
    type_: String,
    focus: String,
    tier: Int,
    effort: Int,
    xp: Int,
    might_pool: StatPool,
    might_edge: Edge,
    speed_pool: StatPool,
    speed_edge: Edge,
    intellect_pool: StatPool,
    intellect_edge: Edge,
    skills: List(Skill),
    abilities: List(Ability),
    cypher_limit: Int,
    cyphers: List(Cypher),
    // Todo: Items and Inventory
  )
}

pub type StatPool {
  StatPool(max: Int, current: Int)
}

pub type Edge =
  Int

pub type SkillProficiency {
  Trained
  Specialized
  Inability
}

pub type Skill {
  Skill(name: String, proficiency: SkillProficiency)
}

pub type PoolCost {
  Might(Int)
  Speed(Int)
  Intellect(Int)
}

pub type Ability {
  Ability(name: String, description: String, cost: Option(PoolCost))
}

pub type Cypher {
  Cypher(name: String, description: String, level: Int)
}

pub fn new() -> Character {
  Character(
    name: "Steve",
    descriptor: "",
    type_: "",
    focus: "",
    tier: 1,
    effort: 1,
    xp: 0,
    might_pool: StatPool(0, 0),
    might_edge: 0,
    speed_pool: StatPool(0, 0),
    speed_edge: 0,
    intellect_pool: StatPool(0, 0),
    intellect_edge: 0,
    skills: [],
    abilities: [],
    cypher_limit: 2,
    cyphers: [],
  )
}
