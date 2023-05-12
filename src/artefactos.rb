require_relative './fuerza_oscura'

class Arma

  def unidadesDeLucha(aventurero)
    3
  end

  def precio(aventurero)
    self.unidadesDeLucha(aventurero) * 5
  end
end

module CollarDivino

  @perlas = 5

  def self.unidadesDeLucha(aventurero)
    @perlas
  end

  def self.perlas(perlas)
    @perlas = perlas
  end

  def self.precio(aventurero)
    @perlas * 2
  end

end

class Mascara

  attr_accessor :indiceDeOscuridad, :minimo

  def initialize(unIndice)
    @indiceDeOscuridad = unIndice
    @minimo = 4
  end

  def unidadesDeLucha(aventurero)
    oscuridad = FuerzaOscura.valor / 2 * @indiceDeOscuridad
    if oscuridad < minimo
      minimo
    else
      oscuridad
    end
  end

  def precio(aventuero)
    70 + FuerzaOscura.valor * @indiceDeOscuridad
  end

end+

module RefuerzoNulo

  def self.valorDeRefuerzo(aventurero)
    0
  end

  def precioArmadura(armadura)
    2
  end

end

class Armadura

  attr_accessor :refuerzo
  attr_reader :valorBase

  def initialize (unRefuerzo, unValorBase)
    @refuerzo = unRefuerzo
    @valorBase = unValorBase
  end

  def unidadesDeLucha(aventurero)
    @valorBase + @refuerzo.valorDeRefuerzo(aventurero)
  end

  def precio(aventurero)
    @refuerzo.precioArmadura(self)
  end

end

class CotaDeMalla

  attr_reader :valorDeRefuerzo

  def initialize(unValor)
    @valorDeRefuerzo = unValor
  end

  def valorDeRefuerzo(aventurero)
    @valorDeRefuerzo
  end

  def precioArmadura
    @valorDeRefuerzo / 2
  end

end

module Bendicion

  def self.valorDeRefuerzo(aventurero)
    aventurero.nivelDeHechiceria
  end

  def precioArmadura(armadura)
    armadura.valorBase
  end
end

module EspejoFantastico

  def self.unidadesDeLucha(aventurero)
    aventurero.unidadesDeLuchaDelMejorArtefactoSin(self)
  end

  def self.precio(aventurero)
    90
  end

end
