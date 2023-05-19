module Hechizo #modulo para heredar mas abajo

  def precio(aventurero)
    self.precioBase
  end

  def precioBase
  end

  def poder
  end

  def precioArmadura(armadura)
    armadura.valorBase + self.precioBase
  end

  def valorDeRefuerzo(aventurero)
    self.poder
  end
end

class HechizoDeLogo
  include Hechizo

  attr_accessor :nombre, :multiplicador

  def initialize(unNombre, unMultiplicador)
    @nombre = unNombre
    @multiplicador = unMultiplicador
  end

  def precioBase
    self.poder
  end

  def poder
    @nombre.size * multiplicador
  end

  def esPoderoso?
    self.poder > 15
  end

end

module HechizoBasico
  extend Hechizo

  def self.poder
    10
  end

  def self.precioBase
    10
  end

  def self.esPoderoso?
    false
  end

end

class LibroDeHechizos

  attr_accessor :hechizos

  def initialize(unosHechizos)
    @hechizos = unosHechizos
  end

  def poder
    hechizosPoderosos.sum { |hechizo| hechizo.poder }
  end

  def esPoderoso?
    @hechizos.any? { |hechizo| hechizo.esPoderoso? }
  end

  def precio(aventurero)
    valorDeHechizosPoderosos = hechizosPoderosos.map {|hechizo|hechizo.poder}
    hechizos.size * 10 + valorDeHechizosPoderosos.sum
  end

  private

  def hechizosPoderosos
    @hechizos.select { |hechizo| hechizo.esPoderoso? }
  end

end