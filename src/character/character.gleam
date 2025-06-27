import character/ability.{type Ability}
import character/cypher.{type Cypher}
import character/skill.{type Skill}
import character/statpool.{type StatPool}
import glanoid
import gleam/dict.{type Dict}
import gleam/int
import gleam/result
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

const skill_prefix: String = "skill"

const ability_prefix: String = "ability"

const cypher_prefix: String = "cypher"

type SkillID =
  String

type CypherID =
  String

type AbilityID =
  String

fn new_char_entry_id(prefix: String) -> String {
  let assert Ok(nanoid) = glanoid.make_generator(glanoid.default_alphabet)
  prefix <> "_" <> nanoid(18)
}

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
    skills: Dict(SkillID, Skill),
    abilities: Dict(AbilityID, Ability),
    cypher_limit: Int,
    cyphers: Dict(CypherID, Cypher),
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
    skills: dict.new(),
    abilities: dict.new(),
    cypher_limit: 2,
    cyphers: dict.new(),
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
  UpdateMightPoolCurrent(Int)
  UpdateMightPoolMax(Int)
  UpdateSpeedPoolCurrent(Int)
  UpdateSpeedPoolMax(Int)
  UpdateIntellectPoolCurrent(Int)
  UpdateIntellectPoolMax(Int)
  AddSkill(Skill)
  UpdateSkill(SkillID, Skill)
  RemoveSkill(SkillID)
  AddCypher(Cypher)
  UpdateCypher(CypherID, Cypher)
  RemoveCypher(CypherID)
  AddAbility(Ability)
  UpdateAbility(AbilityID, Ability)
  RemoveAbility(AbilityID)
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
    UpdateMightPoolCurrent(value) ->
      Character(
        ..character,
        might_pool: statpool.update_current(character.might_pool, value),
      )
    UpdateMightPoolMax(value) ->
      Character(
        ..character,
        might_pool: statpool.update_max(character.might_pool, value),
      )
    UpdateSpeedPoolCurrent(value) ->
      Character(
        ..character,
        speed_pool: statpool.update_current(character.speed_pool, value),
      )
    UpdateSpeedPoolMax(value) ->
      Character(
        ..character,
        speed_pool: statpool.update_max(character.speed_pool, value),
      )
    UpdateIntellectPoolCurrent(value) ->
      Character(
        ..character,
        intellect_pool: statpool.update_current(character.intellect_pool, value),
      )
    UpdateIntellectPoolMax(value) ->
      Character(
        ..character,
        intellect_pool: statpool.update_max(character.intellect_pool, value),
      )
    AddSkill(skill) -> {
      let skills =
        character.skills
        |> dict.insert(new_char_entry_id(skill_prefix), skill)
      Character(..character, skills: skills)
    }
    UpdateSkill(skill_id, skill) -> {
      let skills =
        character.skills
        |> dict.insert(skill_id, skill)
      Character(..character, skills: skills)
    }
    RemoveSkill(skill_id) -> {
      let skills =
        character.skills
        |> dict.delete(skill_id)
      Character(..character, skills: skills)
    }
    AddAbility(ability) -> {
      let abilities =
        character.abilities
        |> dict.insert(new_char_entry_id(ability_prefix), ability)
      Character(..character, abilities: abilities)
    }
    UpdateAbility(ability_id, ability) -> {
      let abilities =
        character.abilities
        |> dict.insert(ability_id, ability)
      Character(..character, abilities: abilities)
    }
    RemoveAbility(ability_id) -> {
      let abilities =
        character.abilities
        |> dict.delete(ability_id)
      Character(..character, abilities: abilities)
    }
    AddCypher(cypher) -> {
      let cyphers =
        character.cyphers
        |> dict.insert(new_char_entry_id(cypher_prefix), cypher)
      Character(..character, cyphers: cyphers)
    }
    UpdateCypher(cypher_id, cypher) -> {
      let cyphers =
        character.cyphers
        |> dict.insert(cypher_id, cypher)
      Character(..character, cyphers: cyphers)
    }
    RemoveCypher(cypher_id) -> {
      let cyphers =
        character.cyphers
        |> dict.delete(cypher_id)
      Character(..character, cyphers: cyphers)
    }
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
  update_fn: fn(String) -> Msg,
) -> Element(Msg) {
  html.input([
    attribute.placeholder(label),
    attribute.class("m-4 border-black border rounded text-center"),
    attribute.type_("text"),
    attribute.value(value),
    event.on_input(update_fn),
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
