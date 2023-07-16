require 'rails_helper'

feature 'Administrador calcula vencedor' do
  scenario 'com sucesso' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    user = User.create!(email: 'user@gmail.com', cpf: '14588117602', password: 'password')
    user2 = User.create!(email: 'user2@gmail.com', cpf: '51027834833', password: 'password')
    lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                      min_value: '400', dif_value: '400', administrator: admin, status: :finished)

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

    login_as admin, scope: :administrator

    visit root_path

    click_on 'Lotes para leilão'
    click_on 'Lotes encerrados'
    click_on 'Calcular vencedor'

    expect(page).to have_content 'Ganhador: user2@gmail.com - valor: R$800'
    expect(page).not_to have_content 'Calcular vencedor'
  end

  scenario 'e vê vencedor ná página do lote' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    user = User.create!(email: 'user@gmail.com', cpf: '14588117602', password: 'password')
    user2 = User.create!(email: 'user2@gmail.com', cpf: '51027834833', password: 'password')
    lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                      min_value: '400', dif_value: '400', administrator: admin, status: :finished)

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

    login_as admin, scope: :administrator

    visit root_path

    click_on 'Lotes para leilão'
    click_on 'Lotes encerrados'
    click_on 'Calcular vencedor'
    visit lot_path(lot)

    expect(page).to have_content 'Vencedor: user2@gmail.com - valor: R$800'
    expect(page).to have_content 'BAH295403'
  end

  scenario 'e não há um vencedor' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                      min_value: '400', dif_value: '400', administrator: admin, status: :finished)

    category = ProdCategory.create!(description: 'Doméstico')
    category2 = ProdCategory.create!(description: 'Eletrônico')
    logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
    product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                              prod_category: category, logo:)
    product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                               prod_category: category2, logo:)

    LotItem.create!(lot:, product:)
    LotItem.create!(lot:, product: product2)

    login_as admin, scope: :administrator

    visit root_path

    click_on 'Lotes para leilão'
    click_on 'Lotes encerrados'
    click_on 'Calcular vencedor'

    expect(page).to have_content 'Não há um vencedor'
    expect(page).not_to have_content 'Calcular vencedor'
  end
end
