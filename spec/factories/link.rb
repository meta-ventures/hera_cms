module HeraCms
  FactoryBot.define do
    factory :link, class: HeraCms::Link do
      identifier { "test-01" }
      path { "https://www.hortatech.com.br" }
      classes { "red-btn large-btn" }
      style { "font-size: 18px;" }
    end
  end
end
