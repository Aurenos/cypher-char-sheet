pub type SkillProficiency {
  Trained
  Specialized
  Inability
}

pub type Skill {
  Skill(name: String, proficiency: SkillProficiency)
}

pub fn new() -> Skill {
  Skill("", Trained)
}
