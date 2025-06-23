import gleam/int

pub type StatPool {
  StatPool(max: Int, current: Int)
}

pub fn new() {
  StatPool(0, 0)
}

pub fn update_current(pool: StatPool, value: Int) -> StatPool {
  StatPool(..pool, current: int.clamp(value, min: 0, max: pool.max))
}

pub fn update_max(pool: StatPool, value: Int) -> StatPool {
  StatPool(..pool, max: int.max(value, 0))
}
