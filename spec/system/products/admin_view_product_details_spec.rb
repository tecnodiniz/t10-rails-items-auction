require 'rails_helper'

feature 'Administrador vê detalhes do produto' do
  scenario 'com sucesso' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', password:'password', cpf: '44047449865')
    category = ProdCategory.create!(description: 'Eletrônico')
    logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
    product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight:'15', depth: '10',
                      prod_category: category, logo: logo)

    login_as admin

    visit root_path
    click_on 'Produtos'

    click_on product.cod

    expect(current_path).to eq product_path(product)
    expect(page).to have_content 'Detalhes do produto'
    expect(page).to have_content 'TV 32 Samsung'
    expect(page).to have_css('img[alt="TV 32 Samsung"]')
    expect(page).to have_content 'Dimensões'
    expect(page).to have_content 'Largura: 30'
    expect(page).to have_content 'Altura: 20'
    expect(page).to have_content 'Peso: 15'
    expect(page).to have_content 'Profundidade: 10'
    expect(page).to have_content 'Categoria: Eletrônico'
    expect(page).to have_content 'status: Disponível'

  end

end