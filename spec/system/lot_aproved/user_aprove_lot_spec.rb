require 'rails_helper'

describe 'Usuário autenticado acessa todos os lotes ' do
  it 'e aprova lote de outro usuário' do
    user = User.create!(email: 'diniz480@gmail.com', password: '@@l0ck3d0u7@@', cpf: '44047449865', admin: true)
    user_2 = User.create!(email: 'eduardo@leilãoestoque.com.br', password: '@@l0ck3d0u7@@', cpf: '61857677676',
                          admin: true)

    c = Category.create!(description: 'Eletro Doméstico')
    c_2 = Category.create!(description: 'Informática')

    Item.create!(name: 'Televisão Samsung', url_img: '', weight: 8000, height: 70, width: 90,
                 depth: 20, code: 'ABXPA0-EJN22-IEDCVHX', category: c)

    Item.create!(name: 'Mouse', url_img: '', weight: 200, height: 10, width: 10,
                 depth: 20, category: c_2)

    Lot.create!(code: 'GAD459812', start_date: '04-04-2022', limit_date: '04-05-2022', min_value: 1000.00,
                dif_value: 500.00, user:)

    Lot.create!(code: 'BAT412820', start_date: '04-04-2022', limit_date: '04-05-2022', min_value: 1000.00,
                dif_value: 500.00, user:)

    login_as(user_2)

    visit root_path

    click_on 'Lotes para leilão'
    click_on 'Visualizar todos os lotes'

    within('table') do
      xpath = "//*[@id='1'] "
      button = find(:xpath, xpath)
      button.click
    end
    expect(page).to have_content 'Lote aprovado'
  end

  it 'e tenta aprovar um lote cadastrado por ele mesmo' do
    user = User.create!(email: 'diniz480@gmail.com', password: '@@l0ck3d0u7@@', cpf: '44047449865', admin: true)
    user_2 = User.create!(email: 'eduardo@leilãoestoque.com.br', password: '@@l0ck3d0u7@@', cpf: '61857677676',
                          admin: true)

    c = Category.create!(description: 'Eletro Doméstico')
    c_2 = Category.create!(description: 'Informática')

    Item.create!(name: 'Televisão Samsung', url_img: '', weight: 8000, height: 70, width: 90,
                 depth: 20, code: 'ABXPA0-EJN22-IEDCVHX', category: c)

    Item.create!(name: 'Mouse', url_img: '', weight: 200, height: 10, width: 10,
                 depth: 20, category: c_2)

    Lot.create!(code: 'GAD459812', start_date: '04-04-2022', limit_date: '04-05-2022', min_value: 1000.00,
                dif_value: 500.00, user:)

    Lot.create!(code: 'BAT412820', start_date: '04-04-2022', limit_date: '04-05-2022', min_value: 1000.00,
                dif_value: 500.00, user:)

    login_as(user)

    visit root_path

    click_on 'Lotes para leilão'
    click_on 'Visualizar todos os lotes'

    within('table') do
      xpath = "//*[@id='1'] "
      button = find(:xpath, xpath)
      button.click
    end

    expect(page).to have_content 'Você não pode aprovar seu próprio lote'
  end
  it 'e vê lote na página de lotes aprovados' do
    user = User.create!(email: 'diniz480@gmail.com', password: '@@l0ck3d0u7@@', cpf: '44047449865', admin: true)
    user_2 = User.create!(email: 'eduardo@leilãoestoque.com.br', password: '@@l0ck3d0u7@@', cpf: '61857677676',
                          admin: true)

    Lot.create!(code: 'GAD459812', start_date: '04-04-2022', limit_date: '04-05-2022', min_value: 1000.00,
                dif_value: 500.00, user:)

    Lot.create!(code: 'BAT412820', start_date: '04-04-2022', limit_date: '04-05-2022', min_value: 1000.00,
                dif_value: 500.00, user:)

    login_as(user_2)

    visit root_path

    click_on 'Lotes para leilão'
    click_on 'Visualizar todos os lotes'

    within('table') do
      xpath = "//*[@id='1'] "
      button = find(:xpath, xpath)
      button.click
    end
    visit lots_path
    expect(page).to have_content 'GAD459812'
  end

  it 'e não vê lote na página de lotes aprovados ao tentar aprovar próprio lote' do
    user = User.create!(email: 'diniz480@gmail.com', password: '@@l0ck3d0u7@@', cpf: '44047449865', admin: true)
    user_2 = User.create!(email: 'eduardo@leilãoestoque.com.br', password: '@@l0ck3d0u7@@', cpf: '61857677676',
                          admin: true)

    Lot.create!(code: 'GAD459812', start_date: '04-04-2022', limit_date: '04-05-2022', min_value: 1000.00,
                dif_value: 500.00, user:)

    Lot.create!(code: 'BAT412820', start_date: '04-04-2022', limit_date: '04-05-2022', min_value: 1000.00,
                dif_value: 500.00, user:)

    login_as(user)

    visit root_path

    click_on 'Lotes para leilão'
    click_on 'Visualizar todos os lotes'

    within('table') do
      xpath = "//*[@id='1'] "
      button = find(:xpath, xpath)
      button.click
    end
    visit lots_path
    expect(page).not_to have_content 'GAD459812'
  end
end
