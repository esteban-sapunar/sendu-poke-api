FactoryBot.define do
  factory :pokemon do
    name { "Test Pokemon" }
    order { 1 }
    base_experience { 1 }
    height { 1 }
    weight { 1 }
    types {"fire,rock"}
  end
end
