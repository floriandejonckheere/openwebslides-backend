# frozen_string_literal: true

FactoryBot.define do
  factory :topic do
    name { Faker::Lorem.words(4).join ' ' }
    description { Faker::Lorem.words(20).join ' ' }
    state :public_access
    user { build :user, :confirmed }

    trait :with_collaborators do
      collaborators { build_list :user, 3 }
    end

    trait :with_assets do
      assets { build_list :asset, 3 }
    end

    trait :with_conversations do
      conversations { build_list :conversation, 3 }
    end
  end
end