# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Review.destroy_all
Idea.destroy_all
User.destroy_all
Like.destroy_all

PASSWORD = 'supersecret'
super_user = User.create(
      first_name: 'chinmaya',
      last_name: 'mathur',
      email: 'cmathur@example.com',
      password: PASSWORD,
      is_admin: true
)


10.times do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      User.create(
            first_name: first_name,
            last_name: last_name,
            email: "#{first_name}.#{last_name}@example.com",
            password: PASSWORD
      )
end

users = User.all

100.times do
      created_at = Faker::Date.backward(days:365 * 5)
            p = Idea.create(
            title: Faker::Hacker.say_something_smart,
            description: Faker::ChuckNorris.fact,
            created_at: created_at,
            updated_at: created_at,
            user: users.sample
            )

            if p.persisted?  
                  p.reviews = rand(0..15).times.map do
                        Review.new(body: Faker::GreekPhilosophers.quote, user: users.sample)

                  end
            end

            p.likers = users.shuffle.slice(0, rand(users.count))
end

ideas = Idea.all
reviews = Review.all

puts Cowsay.say("Generated #{ideas.count} ideas", :cow)
puts Cowsay.say("Generated #{reviews.count} reviews", :koala)
puts Cowsay.say("Generated #{users.count} users", :frogs)
puts Cowsay.say("Generated #{Like.count} likes", :dragon)