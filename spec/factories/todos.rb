FactoryBot.define do
  factory :todo do
    title { "Todo Item" }
    description { "This is a sample todo description" }
    completed { false }
    
    trait :completed do
      completed { true }
    end
    
    trait :pending do
      completed { false }
    end
    
    trait :with_long_description do
      description { "This is a very long description for testing purposes. It should be long enough to test any validation limits or truncation in the views." }
    end
  end
end