require 'rails_helper'

feature 'Usuário faz login na aplicação' do
  scenario 'e vê noticação indicando que há uma mensagem' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    user = User.create!(email: 'user@gmail.com', cpf: '14588117602', password: 'password')
    user2 = User.create!(email: 'user2@gmail.com', cpf: '51027834833', password: 'password')
    lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                      min_value: '400', dif_value: '400', administrator: admin, status: :winned)

    category = ProdCategory.create!(description: 'Doméstico')
    category2 = ProdCategory.create!(description: 'Eletrônico')
    logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
    product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                              prod_category: category, logo:)
    product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                               prod_category: category2, logo:)

    LotItem.create!(lot:, product:)
    LotItem.create!(lot:, product: product2)

    Bid.create!(lot:, user:, value: 400)
    Bid.create!(lot:, user: user2, value: 800)
    Winner.create!(lot:, user: user2)
    UserMessage.create!(user: user2, from_email: admin.email,
                        title: 'Você venceu um leilão',
                        message: "Olá, você venceu o leilão do lote: #{lot.code}, confira os itens",
                        status: :unread)

    login_as user2, scope: :user

    visit root_path

    expect(page).to have_content 'Você tem uma nova mensagem'
  end

  scenario 'e vê noticação indicando que há mensagens' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    user = User.create!(email: 'user@gmail.com', cpf: '14588117602', password: 'password')
    user2 = User.create!(email: 'user2@gmail.com', cpf: '51027834833', password: 'password')
    lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                      min_value: '400', dif_value: '400', administrator: admin, status: :winned)

    category = ProdCategory.create!(description: 'Doméstico')
    category2 = ProdCategory.create!(description: 'Eletrônico')
    logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
    product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                              prod_category: category, logo:)
    product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                               prod_category: category2, logo:)

    LotItem.create!(lot:, product:)
    LotItem.create!(lot:, product: product2)

    Bid.create!(lot:, user:, value: 400)
    Bid.create!(lot:, user: user2, value: 800)
    Winner.create!(lot:, user: user2)
    UserMessage.create!(user: user2, from_email: admin.email,
                        title: 'Você venceu um leilão',
                        message: "Olá, você venceu o leilão do lote: #{lot.code}, confira os itens",
                        status: :unread)
    UserMessage.create!(user: user2, from_email: admin.email,
                        title: 'Dúvida sobre o lote',
                        message: 'Olá, respondendo sua dúdiva, vence quem ter o maior lance sobre o lote',
                        status: :unread)

    login_as user2, scope: :user

    visit root_path

    expect(page).to have_content 'Você tem novas mensagens'
  end
end
