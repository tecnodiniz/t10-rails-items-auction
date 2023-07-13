require 'rails_helper'

feature 'Administrador cadastra produto' do
  scenario 'com sucesso' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', password:'password', cpf: '44047449865')
    category = ProdCategory.create!(description: 'Eletrônico')

    login_as admin

    visit root_path
    click_on 'Produtos'
    click_on 'Cadastrar produto'

    fill_in 'Nome',	with: 'TV 32 Samsung'
    fill_in 'Largura',	with: '30'
    fill_in 'Altura',	with: '20'
    fill_in 'Peso',	with: '15'
    fill_in 'Profundidade', with: '10'
    select category.description, from: 'Categoria'
    attach_file 'product[logo]', Rails.root.join('spec/support/images/logo.png')

    click_on 'Criar Produto'

    expect(current_path).to eq products_path
    expect(page).to have_content 'Produto cadastrato com sucesso'
    expect(page).to have_content 'TV 32 Samsung'
    expect(page).to have_content 'Disponível'
  end
  scenario 'e não preenche todos os campos' do 
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', password:'password', cpf: '44047449865')

    login_as admin

    visit root_path
    click_on 'Produtos'
    click_on 'Cadastrar produto'

    fill_in 'Nome',	with: ''
    fill_in 'Largura',	with: ''
    fill_in 'Altura',	with: ''
    fill_in 'Peso',	with: ''
    fill_in 'Profundidade', with: ''

    click_on 'Criar Produto'

    expect(page).to have_content 'Não foi possível criar o produto'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Categoria é obrigatório(a)'
    expect(page).to have_content 'Largura não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
    expect(page).to have_content 'Profundidade não pode ficar em branco'
    expect(page).to have_content 'Logo não pode ficar em branco'

  end
end