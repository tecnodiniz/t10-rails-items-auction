require 'rails_helper'

feature 'Usuário faz uma dúvida sobre um lote' do
  scenario 'com sucesso' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                      min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
    user = User.create!(email: 'user@example.com', password: 'password', cpf: '47841884281')

    category = ProdCategory.create!(description: 'Doméstico')
    category2 = ProdCategory.create!(description: 'Eletrônico')
    logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
    product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                              prod_category: category, logo:)
    product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                               prod_category: category2, logo:)

    LotItem.create!(lot:, product:)
    LotItem.create!(lot:, product: product2)
    LotDoubt.create!(lot:, user:, doubt: 'Como funcionar o método de pagamento?')

    login_as admin, scope: :administrator

    visit root_path
    click_on lot.code

    fill_in 'Resposta', with: 'Enviamos um boleto'
    click_on 'Enviar Resposta'

    expect(page).to have_content 'Dúvida respondida'
    expect(page).to have_content 'admin@leilaodogalpao.com.br'
    expect(page).to have_content 'Enviamos um boleto'
    expect(page).not_to have_content 'Nenhuma resposta'
  end
end
