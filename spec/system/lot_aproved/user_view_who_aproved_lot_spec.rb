require 'rails_helper'

describe 'Usuário autenticado acessa todos os lotes ' do
  it 'e aprova lote de outro usuário' do
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
    click_on 'GAD459812'

    expect(page).to have_content 'Lote aprovado por: eduardo@leilãoestoque.com.br'
  end
end
