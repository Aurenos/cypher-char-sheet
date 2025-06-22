import character/core as char
import lustre
import lustre/element.{type Element}

import model.{type Model, Model}
import ui.{type Msg}

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

fn init(_args) -> Model {
  model.new()
}

fn update(model: Model, msg: Msg) -> Model {
  case msg {
    ui.UserUpdatesCharacter(update_msg) ->
      Model(character: char.handle_character_update(model.character, update_msg))
  }
}

fn view(model: Model) -> Element(Msg) {
  ui.view_character_core(model)
}
