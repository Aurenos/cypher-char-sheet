// IMPORTS ---------------------------------------------------------------------

import character/core as char
import lustre
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

// MAIN ------------------------------------------------------------------------

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

// MODEL ----------------------------------------------------------------------

pub type Model {
  Model(character: char.Character)
}

fn init(_args) -> Model {
  Model(character: char.new())
}

// UPDATE ----------------------------------------------------------------------

type Msg {
  UserUpdatesCharacter(char.CharacterUpdateMsg)
}

fn update(model: Model, msg: Msg) -> Model {
  case msg {
    UserUpdatesCharacter(update_msg) ->
      Model(character: char.handle_character_update(model.character, update_msg))
  }
}

// VIEW ------------------------------------------------------------------------

fn view(model: Model) -> Element(Msg) {
  view_character_core(model)
}

fn view_character_core(model: Model) -> Element(Msg) {
  html.div([attribute.class("container-xl")], [
    html.input([
      attribute.class("m-4 border-black border rounded-sm"),
      attribute.type_("text"),
      attribute.value(model.character.name),
      event.on_input(fn(value) { UserUpdatesCharacter(char.UpdateName(value)) }),
    ]),
    html.div([], [html.text(model.character.name)]),
  ])
}
