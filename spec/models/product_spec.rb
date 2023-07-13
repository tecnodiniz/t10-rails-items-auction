require 'rails_helper'

RSpec.describe Product, type: :model do
 describe 'valido?' do 
  it 'inválido quando os campos estão em branco' do 
    product = Product.new

    expect(product).not_to be_valid
    expect(product.errors[:name]).to include('não pode ficar em branco')
    expect(product.errors[:width]).to include('não pode ficar em branco')
    expect(product.errors[:height]).to include('não pode ficar em branco')
    expect(product.errors[:weight]).to include('não pode ficar em branco')
    expect(product.errors[:depth]).to include('não pode ficar em branco')
    expect(product.errors[:prod_category]).to include('é obrigatório(a)')
    expect(product.errors[:logo]).to include('não pode ficar em branco')
  end
 end
end
