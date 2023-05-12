require 'rspec'
require_relative '../src/aventurero'

describe 'rolando' do

  let(:rolando){
    Aventurero.new(espectroMalefico,1)
  }
  let(:espectroMalefico){
    HechizoDeLogo.new("Espectro Malefico",1)
  }
  let(:espadaDelDestino){
    Arma.new
  }
  let(:mascaraOscura){
    Mascara.new(1)
  }
  let(:armaduraDeRolando){
    Armadura.new(RefuerzoNulo,2)
  }
  let(:libroDeHechizos){
    LibroDeHechizos.new([espectroMalefico,HechizoBasico])
  }

  before do
    # Este bloque ejecuta antes e cada it
    espectroMalefico.nombre ='Espectro Malefico'
    rolando.hechizoPreferido(espectroMalefico)
    FuerzaOscura.cambiarValor(5)

  end

  after do
    # Do nothing
  end

  context 'nivel de hechiceria' do

    it 'por defecto es de 56' do
      expect(rolando.nivelDeHechiceria).to eq(56)
    end

    it 'con el espectro superrecontramalefico es 125' do
      espectroMalefico.nombre ="espectro superrecontramalefico muajajaja"
      expect(rolando.nivelDeHechiceria).to eq(125)
    end

    it 'con el hechizo basico es 35' do
      rolando.hechizoPreferido(HechizoBasico)
      expect(rolando.nivelDeHechiceria).to eq(35)
    end

    it "si ocurre un eclipse, su nivel de hechiceria es de 61" do
      FuerzaOscura.eclipse!
      expect(rolando.nivelDeHechiceria).to eq(61)
    end

  end

  context "habilidad de lucha" do

    before do
      rolando.artefactos([espadaDelDestino, CollarDivino, mascaraOscura])
      CollarDivino.perlas(5)
      rolando.valorDeLucha(1)
    end

    it "sin artefactos su habilidad es 1" do
      rolando.artefactos([])
      expect(rolando.habilidadDelucha).to be(1)
    end

    it "sin artefactos su habilidad es 1" do
      expect(rolando.habilidadDelucha).to be(13)
    end

    it "si el collar tiene 3 perolas , su habilidad es 11 " do
      CollarDivino.perlas(3)
      expect(rolando.habilidadDelucha).to be(11)
    end

    it "con valor base de 8 , su habilidad e de 20" do
      rolando.valorDeLucha(8)
      expect(rolando.habilidadDelucha).to be(20)
    end

    it "sin la mascara oscura , su habilidad es de 9" do
      rolando.remover(mascaraOscura)
      expect(rolando.habilidadDelucha).to eq(9)
    end

  end

  context "esta cargado y lucha avanzada" do

    before do
      rolando.artefactos([espadaDelDestino, CollarDivino, mascaraOscura, armaduraDeRolando, EspejoFantastico])
      CollarDivino.perlas(5)
      rolando.valorDeLucha(1)
      armaduraDeRolando.refuerzo = RefuerzoNulo
      libroDeHechizos.hechizos = [espectroMalefico, HechizoBasico]
    end

    it "por defecto esta cargado" do
      expect(rolando.estaCargado?).to be_truthy
    end

    it "sacando la armadura no deberia estar cargado" do
      rolando.remover(armaduraDeRolando)
      expect(rolando.estaCargado?).to be_falsey
    end

    it "la habilidad de lucha debe ser 20 " do
      expect(rolando.habilidadDelucha).to eq(20)
    end

    it "La habilidad de lucha solo con el espejo debe ser 1" do
      rolando.artefactos([EspejoFantastico])
      expect(rolando.habilidadDelucha).to eq(1)
    end

    it "El nivel de hechiceria con el libro de hechizos debe ser 56" do
      rolando.hechizoPreferido(libroDeHechizos)
      expect(rolando.nivelDeHechiceria).to eq(56)
    end
  end

end
