require 'rails_helper'

feature 'administrador encerra lote' do
  scenario 'com sucesso' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    admin2 = Administrator.create!(email: 'diniz@leilaodogalpao.com.br', cpf: '51027834833', password: 'password')
    lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                      min_value: '400', dif_value: '400', administrator: admin, status: :aproved)

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
    click_on 'Encerrar leilão'

    expect(page).to have_content 'Leilão encerrado com sucesso'
    expect(page).not_to have_button 'Encerrar leilão'
    expect(page).not_to have_button 'Aprovar lote'
  end

  scenario 'e vê lote ná página de lotes encerrados' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    admin2 = Administrator.create!(email: 'diniz@leilaodogalpao.com.br', cpf: '51027834833', password: 'password')
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

    login_as admin2, scope: :administrator

    visit root_path

    click_on 'Lotes para leilão'
    click_on 'Lotes encerrados'

    expect(page).to have_content 'Lotes finalizados'
    expect(page).to have_content 'BAH295403'
    expect(page).to have_content 'Calcular vencedor'
  end
end
