require 'rails_helper'

feature 'Usuário acessa página inicializado' do
  scenario 'e vê lotes disponíveis em andamento e futuros' do
    user = User.create!(email: 'user@gmail.com', cpf: '66978657689', password: 'password')
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                      min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
    lot2 = Lot.create!(code: 'ZAR295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                       min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
    Lot.create!(code: 'HAZ295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                min_value: '400', dif_value: '400', administrator: admin, status: :awaiting)

    category = ProdCategory.create!(description: 'Doméstico')
    category2 = ProdCategory.create!(description: 'Eletrônico')
    logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
    product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                              prod_category: category, logo:, status: :selected)
    product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                               prod_category: category2, logo:, status: :selected)

    LotItem.create!(lot:, product:)
    LotItem.create!(lot: lot2, product: product2)

    login_as user

    visit root_path

    expect(page).to have_content 'BAH295403'
    expect(page).to have_content 'ZAR295403'
    expect(page).not_to have_content 'HAZ295403'
  end
end
