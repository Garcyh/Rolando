require 'rspec'

require_relative '../src/hechizos'


describe 'Espectro malefico' do

  let(:espectroMalefico){
    HechizoDeLogo.new("Espectro Malefico",1)
  }

  context 'Es poderoso' do

    it 'por defecto es poderoso' do
      expect(espectroMalefico.esPoderoso?).to be_truthy
    end

    it 'con el nombre pepe no es poderoso' do
      espectroMalefico.nombre = "Pepe"
      expect(espectroMalefico.esPoderoso?).to be_falsey
    end

  end

end

describe "Hechizo Basico" do

  context "es poderoso" do

    it "por defecto no es poderoso"do
      expect(HechizoBasico.esPoderoso?).to be_falsey
    end

  end
end
