require 'csv'

DIFFICULTIES = ['Easy', 'Medium', 'Hard']
CUISINES = ['Italian', 'Mexican', 'Asian', 'Indian', 'Mediterranean']
SEASONS = ['Spring', 'Summer', 'Autumn', 'Winter']

# Clear existing data
# User.destroy_all
Recipe.destroy_all

# Read the CSV file
csv_data = CSV.read('db/seed.csv', headers: true)

# Get all unique titles from the CSV data
all_titles = csv_data['title'].uniq

# Create users
15.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password',
    user_name: Faker::Internet.username(specifier: 8..12)
  )

  puts "User '#{user.user_name}' created."
end

# Create recipes
created_titles = []
40.times do
  user = User.order('RANDOM()').first

  available_titles = all_titles - created_titles
  break if available_titles.empty?

  title = available_titles.sample
  created_titles << title

  rows_with_title = csv_data.select { |row| row['title'] == title }

  rows_with_title.each do |row|
    recipe = Recipe.create!(
      title: row['title'],
      description: row['description'],
      meal_type: row['meal_type'],
      season: SEASONS.sample(random: Random.new),
      prep_time: row['prep'],
      total_time: row['total'],
      servings: row['servings'],
      directions: row['directions'],
      difficulty: DIFFICULTIES.sample,
      cuisine: CUISINES.sample(random: Random.new),
      user_id: user.id
    )

    # Add ingredients to the recipe
    ingredients = row['ingredients'].split(',').map(&:strip)
    ingredients.each do |ingredient|
      recipe.ingredients.create!(name: ingredient)
    end

    # Attach images to the recipe
    image_filenames = row['images'].split(',').map(&:strip)
    image_folder_path = 'db/pics'  # Update with the actual image folder path

    image_filenames.each do |filename|
      image_path = File.join(image_folder_path, filename)
      recipe.images.attach(io: File.open(image_path), filename: filename)
    end

    puts "Recipe '#{recipe.title}' created for User '#{user.user_name}'."
  end
end
