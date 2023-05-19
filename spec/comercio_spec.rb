require 'rspec'
require_relative '../src/aventurero'

describe "Comercio de Aventureros" do

  let(:alacachulaCachicomula){
    HechizoDeLogo.new("alacachula cachicomula",1)
  }
  let(:xenia){
    Aventurero.new(alacachulaCachicomula ,1)
  }
  let(:loki){
    Aventurero.new(HechizoBasico,1)
  }
  let(:thor){
    Aventurero.new(HechizoBasico,1)
  }
  let(:espadaDeXenia){
    Arma.new
  }
  let(:armaduraDeXenia){
    Armadura.new(RefuerzoNulo,2)
  }
  let(:armaduraDeCotaXenia){
    Armadura.new(CotaDeMalla.new(5),5)
  }
  let(:armaduraDeThor){
    Armadura.new(Bendicion,2)
  }
  let(:armaduraAlacachulaDeThor){
    Armadura.new(alacachulaCachicomula,2)
  }
  let(:libroDeXenia){
    LibroDeHechizos.new([HechizoBasico,alacachulaCachicomula])
  }
  let(:mascaraDeThor){
    Mascara.new(1)
  }
  let(:mascaraDeXenia){
    Mascara.new(0.5)
  }

  before do
    FuerzaOscura.cambiarValor(5)
  end

  context "Test de xenia" do

    it 'Xenia compra un hechizo basico y deberian quedarle 100 monedas' do
      xenia.comprarHechizo!(HechizoBasico)
      expect(xenia.monedero).to eq(100)
    end
    it 'Xenia le deberian quedar 70.5 en el monedero ' do
      xenia.comprarArtefacto!(espadaDeXenia)
      xenia.comprarArtefacto!(CollarDivino)
      xenia.comprarArtefacto!(armaduraDeXenia)
      xenia.comprarArtefacto!(armaduraDeCotaXenia)
      expect(xenia.monedero).to eq(70.5)
    end

    it 'Xenia compra los artefactos y deberia tener 4 en el inventario ' do
      xenia.comprarArtefacto!(espadaDeXenia)
      xenia.comprarArtefacto!(CollarDivino)
      xenia.comprarArtefacto!(armaduraDeXenia)
      xenia.comprarArtefacto!(armaduraDeCotaXenia)
      expect(xenia.inventario.size).to eq(4)
    end

    it 'Xenia compra un libro de hechizos y deberia quedarle 69' do
      xenia.comprarHechizo!(libroDeXenia)
      expect(xenia.monedero).to eq(69)
    end

    it 'Xenia compra una mascara oscura indice 0.5 cuando hay eclipse, deberian quedarle 25 en el monedero' do
      FuerzaOscura.eclipse!
      xenia.comprarArtefacto!(mascaraDeXenia)
      expect(xenia.monedero).to eq(25)
    end

  end


  context "Test de Thor" do

    it 'Thor cambia de hechizo por alacachula ,y le deberian quedar 83 monedas' do
      thor.comprarHechizo!(alacachulaCachicomula)
      expect(thor.monedero).to eq(83)
    end

    it 'Thor canjea 2 veces el hechizo basico , y le deberian quedar 90 monedas' do
      2.times {thor.comprarHechizo!(HechizoBasico)}
      expect(thor.monedero).to eq(90)
    end

    it 'Thor compra 2 armaduras y deberian quedarle 74 monedas' do
      thor.comprarArtefacto!(armaduraDeThor)
      thor.comprarArtefacto!(armaduraAlacachulaDeThor)
      expect(thor.monedero).to eq(74)
    end

    it 'Thor compra una mascara oscura de indice 1 y deberian quedarle 25 en el monedero' do
      thor.comprarArtefacto!(mascaraDeThor)
      expect(thor.monedero).to eq(25)
    end

  end



  context "Test de Loki" do

    before do
      loki.monedero = 5
    end

    it 'Loki quiere cambiar el hechizo por alacachula , no deberia poder' do
      expect{loki.comprarHechizo!(alacachulaCachicomula)}.to raise_error(message = "No puedo comprar este hechizo, soy pobre")
    end

    it 'Loki quiere comprar un espejo pero no deberia poder' do
      expect{loki.comprarArtefacto!(EspejoFantastico)}.to raise_error(message = "No puedo comprar este objeto , soy pobre ")
    end

  end

end
