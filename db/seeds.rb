# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Variable.create([{name: "CREATION_FEE",value: 10,description: "Job Creation Fee Percentage"},{name: "RESERVATION_FEE",value: 5,description: "Job Reservation Fee Percentage"},
{name: "MIN_PAYMENT",value: 10,description: "Minimum Payment Amount in USD"},{name: "MAX_PAYMENT",value: 100 ,description: "Maximum Payment Amount in USD"},
{name: "MIN_DURATION",value: 1,description: "Minimum Ending Date Range"},{name: "MAX_DURATION",value: 30,description: "Minimum Ending Date Range"},
{name: "RESERVATION_FACTOR",value: 20,description: "Reservation Factor"}])