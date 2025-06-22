import character/ability.{type Ability}
import character/cypher.{type Cypher}
import character/skill.{type Skill}
import character/statpool.{type StatPool}

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
    might_edge: Int,
    speed_pool: StatPool,
    speed_edge: Int,
    intellect_pool: StatPool,
    intellect_edge: Int,
    skills: List(Skill),
    abilities: List(Ability),
    cypher_limit: Int,
    cyphers: List(Cypher),
    // Todo: Items and Inventory
  )
}

pub fn new() -> Character {
  Character(
    name: "",
    descriptor: "",
    type_: "",
    focus: "",
    tier: 1,
    effort: 1,
    xp: 0,
    might_pool: statpool.new(),
    might_edge: 0,
    speed_pool: statpool.new(),
    speed_edge: 0,
    intellect_pool: statpool.new(),
    intellect_edge: 0,
    skills: [],
    abilities: [],
    cypher_limit: 2,
    cyphers: [],
  )
}

pub type CharacterUpdateMsg {
  UpdateName(String)
  UpdateType(String)
  UpdateDescriptor(String)
  UpdateFocus(String)
  UpdateCypherLimit(Int)
  UpdateXP(Int)
  UpdateTier(Int)
  UpdateEffort(Int)
  UpdateMightEdge(Int)
  UpdateSpeedEdge(Int)
  UpdateIntellectEdge(Int)
}

pub fn handle_character_update(
  character: Character,
  msg: CharacterUpdateMsg,
) -> Character {
  case msg {
    UpdateName(value) -> Character(..character, name: value)
    UpdateType(value) -> Character(..character, type_: value)
    UpdateDescriptor(value) -> Character(..character, descriptor: value)
    UpdateFocus(value) -> Character(..character, focus: value)
    UpdateCypherLimit(value) -> Character(..character, cypher_limit: value)
    UpdateXP(value) -> Character(..character, xp: value)
    UpdateTier(value) -> Character(..character, tier: value)
    UpdateEffort(value) -> Character(..character, effort: value)
    UpdateMightEdge(value) -> Character(..character, might_edge: value)
    UpdateSpeedEdge(value) -> Character(..character, speed_edge: value)
    UpdateIntellectEdge(value) -> Character(..character, intellect_edge: value)
  }
}
