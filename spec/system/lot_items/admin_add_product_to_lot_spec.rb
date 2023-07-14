require 'rails_helper'

feature 'Administrador adicionar item ao lote' do
  scenario 'com sucesso' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                      min_value: '400', dif_value: '400', administrator: admin)

    category = ProdCategory.create!(description: 'Doméstico')
    category2 = ProdCategory.create!(description: 'Eletrônico')
    logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
    product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                              prod_category: category, logo:)
    product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                               prod_category: category2, logo:)

    login_as admin

    visit root_path
    click_on 'Lotes'
    click_on lot.code
    click_on 'Adicionar itens'
    select product.name, from: 'Produto'
    click_on 'Adicionar'
    click_on 'Adicionar itens'
    select product2.name, from: 'Produto'
    click_on 'Adicionar'

    expect(page).to have_content 'Itens do lote'
    expect(page).to have_content 'TV 32 Samsung'
    expect(page).to have_content 'SOUNDBAR SONY'
  end

  scenario 'e não vê item já adicionar na pagina de adição de itens' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                      min_value: '400', dif_value: '400', administrator: admin)

    category = ProdCategory.create!(description: 'Doméstico')
    category2 = ProdCategory.create!(description: 'Eletrônico')
    logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
    product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                              prod_category: category, logo:)
    Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                    prod_category: category2, logo:)

    login_as admin

    visit root_path
    click_on 'Lotes'
    click_on lot.code
    click_on 'Adicionar itens'
    select product.name, from: 'Produto'
    click_on 'Adicionar'
    click_on 'Adicionar itens'

    expect(page).not_to have_select('Produto', with_options: ['TV 32 Samsung'])
    expect(page).to have_select('Produto', with_options: ['SOUNDBAR SONY'])
  end
end
