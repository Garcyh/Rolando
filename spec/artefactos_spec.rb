require 'rspec'
require_relative '../src/artefactos'
require_relative '../src/aventurero'

describe 'Artefactos' do

  let(:espectroMalefico) {
    HechizoDeLogo.new("Espectro Malefico", 1)
  }
  let(:rolando) {
    Aventurero.new(espectroMalefico, 1)
  }
  let(:mascaraOscura) {
    Mascara.new(1)
  }
  let(:armaduraDeRolando) {
    Armadura.new(RefuerzoNulo, 2)
  }
  let(:mascaraParaNadaOscura) {
    Mascara.new(0)
  }

  before do
    FuerzaOscura.cambiarValor(5)
    armaduraDeRolando.refuerzo = RefuerzoNulo
  end

  context 'valor de lucha' do

    it 'cuando hay un eclipse, su valor es 5' do
      FuerzaOscura.eclipse!
      expect(mascaraOscura.unidadesDeLucha(rolando)).to be(5)
    end

    it "puntos de habildiad de la armadura con bendicion" do
      armaduraDeRolando.refuerzo = Bendicion
      expect(armaduraDeRolando.unidadesDeLucha(rolando)).to eq(58)
    end

    it "puntos de habildiad de la armadura con cota de malla" do
      armaduraDeRolando.refuerzo = CotaDeMalla.new(1)
      expect(armaduraDeRolando.unidadesDeLucha(rolando)).to eq(3)
    end

    it "puntos de habildiad de la armadura con hechizo basico" do
      armaduraDeRolando.refuerzo = HechizoBasico
      expect(armaduraDeRolando.unidadesDeLucha(rolando)).to eq(12)
    end

    it "puntos de habildiad de la armadura con espectro malefico" do
      armaduraDeRolando.refuerzo = espectroMalefico
      expect(armaduraDeRolando.unidadesDeLucha(rolando)).to eq(19)
    end

  end

  context "Lucha reformulada, mascara para nada oscura " do

    it "El valor de lucha deberia ser 4 " do
      expect(mascaraParaNadaOscura.unidadesDeLucha(rolando)).to eq(4)
    end

    it "Cambiando el minimo el valor de lucha deberia ser 2" do
      mascaraParaNadaOscura.minimo = 2
      expect(mascaraParaNadaOscura.unidadesDeLucha(rolando)).to eq(2)
    end
  end

end

