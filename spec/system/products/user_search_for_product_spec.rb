require 'rails_helper'

feature 'Usuário pesquisa por produto' do
  scenario 'com sucesso' do
    user = User.create!(email: 'user@gmail.com', cpf: '14588117602', password: 'password')
    category = ProdCategory.create!(description: 'Doméstico')
    category2 = ProdCategory.create!(description: 'Eletrônico')
    logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
    Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                    prod_category: category, logo:)
    Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                    prod_category: category2, logo:)

    login_as user, scope: :user

    visit root_path

    fill_in 'Pesquisar Produto', with: 'TV'
    within('nav') do
      find('.search-button').click
    end

    expect(page).to have_content 'Resultado da pesquisa'
    expect(page).to have_content 'TV 32 Samsung'
    expect(page).not_to have_content 'SOUNDBAR SONY'
  end

  scenario 'e não obtém resultado' do
    user = User.create!(email: 'user@gmail.com', cpf: '14588117602', password: 'password')
    category = ProdCategory.create!(description: 'Doméstico')
    category2 = ProdCategory.create!(description: 'Eletrônico')
    logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
    Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                    prod_category: category, logo:)
    Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                    prod_category: category2, logo:)

    login_as user, scope: :user

    visit root_path

    fill_in 'Pesquisar Produto', with: 'Video Game'
    within('nav') do
      find('.search-button').click
    end

    expect(page).to have_content 'Nenhum resultado encontrado'
    expect(page).not_to have_content 'TV 32 Samsung'
    expect(page).not_to have_content 'SOUNDBAR SONY'
  end

  scenario 'e vê detalhes do produto' do
    user = User.create!(email: 'user@gmail.com', cpf: '14588117602', password: 'password')
    category = ProdCategory.create!(description: 'Doméstico')
    category2 = ProdCategory.create!(description: 'Eletrônico')
    logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
    produto = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                              prod_category: category, logo:)
    Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                    prod_category: category2, logo:)

    login_as user, scope: :user

    visit root_path

    fill_in 'Pesquisar Produto', with: 'TV'
    within('nav') do
      find('.search-button').click
    end
    click_on produto.cod

    expect(page).to have_content 'Detalhes do produto'
    expect(page).to have_content 'TV 32 Samsung'
    expect(page).to have_css('img[alt="TV 32 Samsung"]')
    expect(page).to have_content 'Dimensões'
    expect(page).to have_content 'Largura: 30'
    expect(page).to have_content 'Altura: 20'
    expect(page).to have_content 'Peso: 15'
    expect(page).to have_content 'Profundidade: 10'
    expect(page).to have_content 'Categoria: Doméstico'
    expect(page).to have_content 'status: Disponível'
  end
end
