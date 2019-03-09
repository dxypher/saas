FactoryBot.define do
  factory :team do
    name { "MyString" }
    account { nil }
    timezone { "MyString" }
    has_reminder { false }
    has_recap { false }
    hash_id { "MyString" }
    reminder_time { "2019-03-09 12:59:28" }
    recap_time { "2019-03-09 12:59:28" }
  end
end
