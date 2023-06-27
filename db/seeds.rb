require 'faker'

20.times do
  # event = Event.new(
  #   title: Faker::Lorem.words(number: 3).join(' '),
  #   description: Faker::Lorem.paragraph,
  #   date: Faker::Time.between(from: DateTime.now, to: DateTime.now + 30.days),
  #   paid: false
  # )
  # event.user = User.all.sample
  # event.save!

  Recipe.create!(
    title: Faker::Food.dish,
    description: Faker::Food.description,
    ingredients: Faker::Food.ingredient,
    meal_type: Recipe::MEAL_TYPES.sample,
    cuisine: Faker::Food.ethnic_category,
    dietary_requirements: Recipe::DIET.sample,
    prep_time: rand(5..15),
    total_time: rand(60..120),
    difficulty: ['easy', 'medium', 'hard'].sample,
    servings: 5,
    season: Recipe::SEASONS.sample,
    directions: Faker::Food.description,
    user_id: 1
  )
end
