FactoryGirl.define do
  factory :album do
    sequence(:name) {|n| "album_name_#{n}"}
    sequence(:year) {|n| n }
  end
end