require 'rails_helper'

feature 'Administrador aprova lote' do
  scenario 'com sucesso' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    admin2 = Administrator.create!(email: 'diniz@leilaodogalpao.com.br', cpf: '51027834833', password: 'password')
    lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                      min_value: '400', dif_value: '400', administrator: admin)

    category = ProdCategory.create!(description: 'Doméstico')
    category2 = ProdCategory.create!(description: 'Eletrônico')
    logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
    product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                              prod_category: category, logo:)
    product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                               prod_category: category2, logo:)

    LotItem.create!(lot:, product:)
    LotItem.create!(lot:, product: product2)

    login_as admin2, scope: :administrator

    visit root_path
    click_on 'Lotes'
    click_on lot.code
    click_on 'Aprovar lote'

    expect(page).to have_content 'Lote aprovado com sucesso'
    expect(page).not_to have_button 'Aprovar lote'
  end
  scenario 'e ve lote na página principal' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    admin2 = Administrator.create!(email: 'diniz@leilaodogalpao.com.br', cpf: '51027834833', password: 'password')
    lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                      min_value: '400', dif_value: '400', administrator: admin)

    category = ProdCategory.create!(description: 'Doméstico')
    category2 = ProdCategory.create!(description: 'Eletrônico')
    logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
    product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                              prod_category: category, logo:)
    product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                               prod_category: category2, logo:)

    LotItem.create!(lot:, product:)
    LotItem.create!(lot:, product: product2)

    login_as admin2, scope: :administrator

    visit root_path
    click_on 'Lotes'
    click_on lot.code
    click_on 'Aprovar lote'
    visit root_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'BAH295403'
  end
end