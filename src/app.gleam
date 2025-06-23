// IMPORTS ---------------------------------------------------------------------

import character/character as char
import lustre
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

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
  CharacterMsg(char.Msg)
}

fn update(model: Model, msg: Msg) -> Model {
  case msg {
    CharacterMsg(update_msg) ->
      Model(character: char.update(model.character, update_msg))
  }
}

// VIEW ------------------------------------------------------------------------

fn view(model: Model) -> Element(Msg) {
  html.div([attribute.class("container")], [
    char.view(model.character) |> element.map(CharacterMsg),
  ])
}
