# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)

admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
Administrator.create!(email: 'diniz@leilaodogalpao.com.br', cpf: '41404547509', password: 'password')
User.create!(email: 'user@gmail.com', cpf: '14588117602', password: 'password')
User.create!(email: 'user2@gmail.com', cpf: '51027834833', password: 'password')
Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
            min_value: '400', dif_value: '400', administrator: admin, status: :finished)
Lot.create!(code: 'ZHA295956', start_date: Time.zone.today, limit_date: 5.days.from_now,
            min_value: '400', dif_value: '400', administrator: admin)

prod_category = ProdCategory.create!(description: 'Eletrônico')

Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                prod_category:, logo: { io: Rails.root.join('spec/support/images/logo.png').open,
                                        filename: 'logo.png', content_type: 'image/png' })
Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                prod_category:, logo: { io: Rails.root.join('spec/support/images/logo.png').open,
                                        filename: 'logo.png', content_type: 'image/png' })
