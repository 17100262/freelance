
User.create!([{email: "admin@test.com",password: "admin123",admin: true,username: "admin",name: "admin"},{email: "user@test.com",password: "admin123",username: "user",name: "Sohail"},{email: "user1@test.com",password: "admin123",username: "user1",name: "Aslam"}])
Category.create!([{name: "Graphics & Design"},{name: "Digital Marketing"},{name: "Writing & Translation"},{name: "Video & Animation"},{name: "Music & Audio"},{name: "Programming & Tech"},{name: "Business"},{name: "Lifestyle"},{name: "Other"}])
category = Category.find_by_name("Graphics & Design")
category.subcategories.create!([{name: "Logo Design"},{name: "Business Cards & Stationery Design"},{name: "Flyers & Brochures"},{name: "Packaging Design"},{name: "Web & Mobile Design"},{name: "Social Media Design"},{name: "Banner Ads"},{name: "Photoshop Editing"},{name: "Merchandise"},{name: "Presentation Design"},{name: "Infographics"},{name: "Vector Tracing"},{name: "Invitations"},{name: "Other"}])

category = Category.find_by_name("Digital Marketing")
category.subcategories.create!([{name: "Social Media Marketing"},{name: "SEO"},{name: "Search & Display Marketing"},{name: "Content Marketing"},{name: "Video Marketing"},{name: "Email Marketing"},{name: "Influencer Marketing"},{name: "Marketing Strategy"},{name: "Web Analytics"},{name: "Local Listings"},{name: "E-Commerce Marketing"},{name: "Mobile Advertising"},{name: "Web Traffic"},{name: "Other"}])

category = Category.find_by_name("Writing & Translation")
category.subcategories.create!([{name: "Resumes & Cover Letters"},{name: "Proofreading & Editing"},{name: "Translation"},{name: "Creative Writing"},{name: "Business Copywriting"},{name: "Research"},{name: "Articles & Blog Posts"},{name: "Press Releases"},{name: "Transcription"},{name: "Legal Writing"},{name: "Other"}])

category = Category.find_by_name("Video & Animation")
category.subcategories.create!([{name: "Whiteboard & Animated Explainers"},{name: "Intros & Animated Logos"},{name: "Promotional Videos"},{name: "Editing & Post Production"},{name: "Lyric & Music Videos"},{name: "Spokesperson Videos"},{name: "Animated Characters & Modeling"},{name: "Short Video Ads"},{name: "Other"}])

category = Category.find_by_name("Music & Audio")
category.subcategories.create!([{name: "Voice Over"},{name: "Mixing & Mastering"},{name: "Producers & Composers"},{name: "Singer-Songwriters"},{name: "Session Musicians & Singers"},{name: "Jingles & Drops"},{name: "Sound Effects"},{name: "Other"}])

category = Category.find_by_name("Programming & Tech")
category.subcategories.create!([{name: "WordPress"},{name: "Website Builders & CMS"},{name: "Web Programming"},{name: "Ecommerce"},{name: "Mobile Apps & Web"},{name: "Desktop applications"},{name: "Support & IT"},{name: "Chatbots"},{name: "Data Analysis & Reports"},{name: "Convert Files"},{name: "Databases"},{name: "User Testing"},{name: "QA"},{name: "Other"}])

category = Category.find_by_name("Business")
category.subcategories.create!([{name: "Market Research"},{name: "Business Plans"},{name: "Branding Services"},{name: "Legal Consulting"},{name: "Financial Consulting"},{name: "Business Tips"},{name: "Presentations"},{name: "Career Advice"},{name: "Other"}])

category = Category.find_by_name("Lifestyle")
category.subcategories.create!([{name: "Health, Nutrition & Fitness"},{name: "Gaming"},{name: "Greeting Cards & Videos"},{name: "Your Message On..."},{name: "Viral Videos"},{name: "Celebrity Impersonations"},{name: "Other"}])



Variable.create!([{name: "CREATION_FEE",value: 10,description: "Job Creation Fee Percentage"},{name: "MIN_PAYMENT",value: 10,description: "Minimum Payment Amount in USD"},{name: "MAX_PAYMENT",value: 100 ,description: "Maximum Payment Amount in USD"},
{name: "MIN_DURATION",value: 1,description: "Minimum Ending Date Range"},{name: "MAX_DURATION",value: 30,description: "Maximum Ending Date Range"},
{name: "RESERVATION_FACTOR",value: 20,description: "Reservation Factor"},{name: "MAX_RESERVATIONS",value: 2,description: "Maximum Number of Simultaneous Reservations as a worker"},
{name: "MAX_JOBS",value: 5,description: "Maximum Number of Simultaneous Jobs as an Employer"},{name: "MAX_FILES",value: 10,description: "Maximum Number of Files a user can attach with Jobs"},{name: "MAX_FILES_SIZE",value: 200,description: "Total File Size Limit of Files a user can attach with Jobs"}])

400.times do 
    Job.create!(
        status: "LIVE",
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph,
        deliverables: Faker::Lorem.paragraph,
        duration: Faker::Number.between(5,20),
        language: "English",
        amount: Faker::Number.number(3),
        online: true,
        user_id: [2,3].sample,
        category_id: Category.pluck(:id).sample,
        subcategory_id: Subcategory.pluck(:id).sample
    )
end