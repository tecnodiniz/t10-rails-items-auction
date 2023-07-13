require 'rails_helper'

feature 'Administrador edita produto' do
  scenario 'com sucesso ' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', password:'password', cpf: '44047449865')
    category = ProdCategory.create!(description: 'Doméstico')
    category2 = ProdCategory.create!(description: 'Eletrônico')
    logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
    product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight:'15', depth: '10',
                      prod_category: category, logo: logo)

    login_as admin

    visit root_path
    click_on 'Produtos'

    click_on product.cod
    click_on 'Editar'

    fill_in 'Nome',	with: 'TV 32" Samsung'
    fill_in 'Largura',	with: '60'
    fill_in 'Altura',	with: '40'
    fill_in 'Peso',	with: '5'
    fill_in 'Profundidade', with: '3'
    select category.description, from: 'Categoria'
    
    click_on 'Atualizar Produto'
   

    expect(page).to have_content 'Produto editado com sucesso'
    expect(page).to have_content 'TV 32" Samsung'
    expect(page).to have_content 'Dimensões'
    expect(page).to have_content 'Largura: 60'
    expect(page).to have_content 'Altura: 40'
    expect(page).to have_content 'Peso: 5'
    expect(page).to have_content 'Profundidade: 3'
    expect(page).to have_content 'Categoria: Doméstico'
    expect(page).to have_content 'status: Disponível'
    

  end

end