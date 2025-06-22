import character/core as char
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import model.{type Model}

pub type Msg {
  UserUpdatesCharacter(char.CharacterUpdateMsg)
}

pub fn view_character_core(model: Model) -> Element(Msg) {
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
