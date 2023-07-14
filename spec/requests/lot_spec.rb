require 'rails_helper'

describe 'Página de lotes', type: :request do
  it 'administrador acessar página de lotes com sucesso' do
    user = Administrator.create!(email: 'diniz@leilaodogalpao.com.br', password: 'password', cpf: '44047449865')

    login_as user

    get lots_path

    expect(response).to have_http_status(:ok)
  end
  context 'usuário tenta acessar página de lotes' do
    it 'e não tem permissão' do
      user = User.create!(email: 'diniz@gmail.com', password: 'password', cpf: '44047449865')

      login_as user

      get lots_path

      follow_redirect!

      expect(response.body).to include 'Acesso não autorizado.'
    end
  end

  context 'usuário acessa página de detalhes de lote' do
    it 'com sucesso pois lote está aprovado' do
      user = User.create!(email: 'user@gmail.com', cpf: '66978657689', password: 'password')
      admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
      lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                        min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      lot2 = Lot.create!(code: 'ZAR295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                         min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      lot3 = Lot.create!(code: 'HAZ295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                         min_value: '400', dif_value: '400', administrator: admin, status: :aproved)

      category = ProdCategory.create!(description: 'Doméstico')
      category2 = ProdCategory.create!(description: 'Eletrônico')
      logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
      product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                                prod_category: category, logo:, status: :selected)
      product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                                 prod_category: category2, logo:, status: :selected)

      LotItem.create!(lot:, product:)
      LotItem.create!(lot: lot2, product: product2)

      login_as user

      get lot_path(lot3)

      expect(response).to have_http_status(:ok)
    end
    it 'e falha pois lote está aguardando aprovação' do
      user = User.create!(email: 'user@gmail.com', cpf: '66978657689', password: 'password')
      admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
      lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                        min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      lot2 = Lot.create!(code: 'ZAR295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                         min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      lot3 = Lot.create!(code: 'HAZ295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                         min_value: '400', dif_value: '400', administrator: admin, status: :awaiting)

      category = ProdCategory.create!(description: 'Doméstico')
      category2 = ProdCategory.create!(description: 'Eletrônico')
      logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
      product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                                prod_category: category, logo:, status: :selected)
      product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                                 prod_category: category2, logo:, status: :selected)

      LotItem.create!(lot:, product:)
      LotItem.create!(lot: lot2, product: product2)

      login_as user

      get lot_path(lot3)

      follow_redirect!
      expect(response.body).to include 'Acesso não autorizado'
    end
  end
end
