FactoryBot.define do
  factory :standup do
    user
    standup_date { "2019-03-05" }
    hash_id { "MyString" }
  end
end
