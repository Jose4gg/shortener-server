namespace :data do
  task create_random_url: :environment do
    200.times do 
      begin
        Website.create(
          title: Faker::Lorem.sentence,
          url: Faker::Internet.url,
          visited_count: rand(1..5000),
          processing_title: false
        )
      rescue => exception
      end
    end
  end
end