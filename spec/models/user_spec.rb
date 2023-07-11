require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#valid?' do
    context 'validation' do
      it 'cpf válido' do
        user = User.new(email: 'test@example.com', password: 'eduardo123', password_confirmation: 'eduardo123',
                        cpf: '44047449865')

        expect(user).to be_valid
      end
      it 'cpf inválido' do
        user = User.new(email: 'test@example.com', password: 'eduardo123', password_confirmation: 'eduardo123',
                        cpf: '44047449869')

        expect(user).not_to be_valid
      end

      it 'cpf já cadastrado' do
        user_1 = User.create!(email: 'test@example.com', password: 'eduardo123', password_confirmation: 'eduardo123',
                              cpf: '44047449865')
        user_2 = User.new(email: 'test@example.com', password: 'eduardo123', password_confirmation: 'eduardo123',
                          cpf: '44047449865')

        expect(user_2).not_to be_valid
      end
    end
  end
end
