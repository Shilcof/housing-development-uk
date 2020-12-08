
# seed users
15.times do
    params = {}
    names = Faker::Name.unique.name.split
    params[:first_name] = names[0]
    params[:first_name] = names[1]
    email = Faker::Internet.email
    params[:email] = email
    params[:password] = email.split("@")[0]

    User.create(params)
end

#seed developers and their developments
5.times do
    params = {}
    names = Faker::Name.unique.name.split
    params[:first_name] = names[0]
    params[:first_name] = names[1]
    email = Faker::Internet.email
    params[:email] = email
    params[:password] = email.split("@")[0]
    params[:developer] = true
    company = Faker::Company.unique.bs
    params[:company] = company
    params[:website] = company.join("-") + ".com"

    developer = User.create(params)

    rand(6..10).times do
        development = {}
        title = Faker::Lorem.words(number: 3)
        development[:title] = title.join(" ").capitalize

        body = (1..rand(6..10)).collect{ |a|
            (1..rand(6..10)).collect{ |b| Faker::Lorem.words(number: rand(7..11)).join(" ").capitalize }.join(". ") + "."
        }.join("\r\n\r\n")

        development[:body] = body

        developer.developments.build(development)
    end
end

# Faker::Address