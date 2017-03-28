namespace :dev do

  task :fake => :environment do
    User.delete_all
    Topic.delete_all
    Comment.delete_all

    user = User.create!( email: 'ac01@alpha.com',
                         password: '111111',
                         first_name: 'Bruce',
                         last_name: 'Wayne',
                         nickname: 'The Dark Knight')

    10.times do #隨機產生10個使用者
      # users = []
      User.create!(email: Faker::Internet.email,
                            password: '111111',
                            first_name: Faker::Name.first_name,
                            last_name: Faker::Name.last_name,
                            nickname: Faker::Pokemon.name)
    end

    35.times do #隨機產生35篇文章
      topic = Topic.create!( :title => Faker::Cat.name,
                     :content => Faker::Lorem.paragraph,
                     :user_id => User.all.sample.id,
                     :category_id => Category.all.sample.id)

      rand(10).times do #隨機在每篇文章中隨機產生0-10則的留言，且個別屬於隨機一名使用者
        Comment.create!( :user => User.all.sample,
                         :topic => topic,
                         :message => Faker::Lorem.sentence )
      end
    end
  end
end