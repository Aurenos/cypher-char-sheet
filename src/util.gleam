import glanoid

pub fn new_element_id(prefix: String) -> String {
  let assert Ok(nanoid) = glanoid.make_generator(glanoid.default_alphabet)
  prefix <> "_" <> nanoid(18)
}
