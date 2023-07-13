require 'rails_helper'

describe 'Página de lotes', type: :request do
  context 'usuário tenta acessar página de lotes' do
    it 'e não tem permissão' do
      user = User.create!(email:'diniz@gmail.com', password:'password', cpf: '44047449865')
 
      login_as user

      get lots_path

      follow_redirect!

      expect(response.body).to include 'Acesso não autorizado.'
    end
  end

 
end
