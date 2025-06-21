// IMPORTS ---------------------------------------------------------------------

import character as char
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

pub type Model =
  char.Character

fn init(_args) -> Model {
  char.new()
}

// UPDATE ----------------------------------------------------------------------

type Msg {
  UserChangesName(String)
}

fn update(model: Model, msg: Msg) -> Model {
  case msg {
    UserChangesName(value) -> char.Character(..model, name: value)
  }
}

// VIEW ------------------------------------------------------------------------

fn view(model: Model) -> Element(Msg) {
  html.div([], [
    html.input([
      attribute.type_("text"),
      attribute.value(model.name),
      event.on_change(fn(value) { UserChangesName(value) }),
    ]),
    html.div([], [html.text(model.name)]),
  ])
}
