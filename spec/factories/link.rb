module HeraCms
  FactoryBot.define do
    factory :link, class: HeraCms::Link do
      sequence(:identifier) { |n| "test-#{n}" }
      path { "https://www.hortatech.com.br" }
      classes { "red-btn large-btn" }
      style { "font-size: 18px;" }
    end
  end
end
