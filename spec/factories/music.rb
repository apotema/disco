FactoryGirl.define do
  factory :music do
    sequence(:name) {|n| "music_name_#{n}"}
    album
  end
end