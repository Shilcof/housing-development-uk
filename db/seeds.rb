NAMES = [
    "John Smith",
    "Owen Jones",
    "Mark Wilson",
    "Sam Piper",
    "Tony Watson",
    "Seamus Austin",
    "Peter Hamill",
    "Paul Newman",
    "Jane Taylor",
    "Stacy Foster",
    "Mary Johnson",
    "Elizabeth Walker",
    "Annie Potter",
    "Pauline Hooper",
    "Jennifer Hamilton"
]

# seed users
i = 0
15.times do
    params = {}
    names = NAMES[i].split(" ")
    params[:first_name] = names[0]
    params[:last_name] = names[1]
    email = names[0]
    params[:email] = email + "@email.com"
    params[:password] = email

    User.create(params)
    i += 1
end

#seed developers and their developments
5.times do
    params = {}
    names = Faker::Name.unique.name.split
    params[:first_name] = names[0]
    params[:last_name] = names[1]
    params[:developer] = true

    company = Faker::Company.unique.bs
    slugged = company.split(" ").join("-").downcase

    params[:email] = slugged + "@email.com"
    params[:password] = slugged
    params[:company] = company
    params[:website] = slugged + ".com"

    developer = User.create(params)

    rand(6..10).times do
        development = {}
        title = Faker::Lorem.words(number: 3)
        development[:title] = title.join(" ").capitalize

        content = (1..rand(6..10)).collect{ |a|
            (1..rand(6..10)).collect{ |b| Faker::Lorem.words(number: rand(7..11)).join(" ").capitalize }.join(". ") + "."
        }.join("\r\n\r\n")

        development[:content] = content

        developer.developments.build(development)
    end
    developer.save
end

User.all.each do |user|
    if user.developer
    else
        User.where(developer: true).each do |developer|
            if rand(1..5) > 3
                FollowerDeveloper.create(follower_id: user.id, developer_id: developer.id)
                developer.developments.each do |development|
                    if [true, false].sample
                        Comment.create(user_id: user.id,development_id: development.id,body: (1..rand(6..10)).collect{ |b| Faker::Lorem.words(number: rand(7..11)).join(" ").capitalize }.join(". ") + ".",rating: rand(1..5))
                    end
                end
            end
        end
    end
end

# Faker::Address