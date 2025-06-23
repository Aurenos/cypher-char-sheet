import character/ability.{type Ability}
import character/cypher.{type Cypher}
import character/skill.{type Skill}
import character/statpool.{type StatPool}
import gleam/int
import gleam/result
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

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

pub type Msg {
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

pub fn update(character: Character, msg: Msg) -> Character {
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

pub fn view(character: Character) -> Element(Msg) {
  view_character_basics(character)
}

fn view_character_basics(character: Character) -> Element(Msg) {
  html.div([], [
    basic_input("Name", character.name, fn(value) { UpdateName(value) }),
    html.text("is a"),
    basic_input("Descriptor", character.descriptor, fn(value) {
      UpdateDescriptor(value)
    }),
    html.text("that"),
    basic_input("Focus", character.focus, fn(value) { UpdateFocus(value) }),
    integer_input("Tier", character.tier, fn(value) { UpdateTier(value) }),
    integer_input("XP", character.xp, fn(value) { UpdateXP(value) }),
    integer_input("Effort", character.effort, fn(value) { UpdateEffort(value) }),
    html.div([], [html.text(character.name)]),
  ])
}

fn basic_input(
  label: String,
  value: String,
  on_input: fn(String) -> Msg,
) -> Element(Msg) {
  html.input([
    attribute.placeholder(label),
    attribute.class("m-4 border-black border rounded text-center"),
    attribute.type_("text"),
    attribute.value(value),
    event.on_input(on_input),
  ])
}

fn integer_input(label: String, value: Int, update_fn: fn(Int) -> Msg) {
  html.input([
    attribute.placeholder(label),
    attribute.class("m-4 border-black border rounded text-center"),
    attribute.type_("number"),
    attribute.value(int.to_string(value)),
    event.on_input(fn(new_value) {
      new_value |> int.parse() |> result.unwrap(value) |> update_fn
    }),
  ])
}
