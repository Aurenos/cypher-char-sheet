import gleeunit

import util

pub fn main() -> Nil {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn bnyeh_test() {
  echo util.new_element_id("skill")
}
