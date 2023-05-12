require_relative './hechizos'
require_relative './fuerza_oscura'
require_relative './artefactos'

class Aventurero

  attr_accessor :valorBase, :hechizoPreferido, :valorDeLucha, :inventario ,:monedero

  def initialize( unHehcizo, unValorDeLucha)
    @valorBase = 3
    @hechizoPreferido = unHehcizo
    @valorDeLucha = unValorDeLucha
    @inventario = []
    @monedero = 100
  end


  def comprar()
    
  end

  def nivelDeHechiceria
    @valorBase * @hechizoPreferido.poder + FuerzaOscura.valor
  end

  def hechizoPreferido(unHechizo)
    @hechizoPreferido = unHechizo
  end

  def esPoderoso?
    @hechizoPreferido.esPoderoso?
  end

  def valorDeLucha(unValor)
    @valorDeLucha = unValor
  end

  def agregar(artefacto)
    @inventario.push(artefacto)
  end

  def remover(artefacto)
    @inventario.delete(artefacto)
  end

  def habilidadDelucha
    @valorDeLucha + @inventario.sum { |artefacto| artefacto.unidadesDeLucha(self) }
  end

  def esMasGuerreroQueHechicero?
    self.habilidadDelucha > self.nivelDeHechiceria
  end

  def unidadesDeLuchaDelMejorArtefactoSin(artefacto)

    inventarioFiltrado = @inventario.select { |a| a != artefacto }

    if inventarioFiltrado.empty?
      0
    else
      inventarioFiltrado.map { |a| a.unidadesDeLucha(self) }.max
    end

  end

  def estaCargado?
    @inventario.size >= 5
  end

  def artefactos(nuevosArtefactos)
    @inventario = nuevosArtefactos
  end

  def completarObjetivo
    @monedero += 10
  end

  def puedoComprar?(artefacto)
    artefacto.precio(self) <= @monedero
  end

  def comprarArtefacto!(artefacto)

    if !puedoComprar?(artefacto)
      raise NoPuedoComprar.new("No puedo comprar este objeto , soy pobre ")
    end

    @inventario.push(artefacto)
    @monedero -= artefacto.precio(self)

  end

end

class NoPuedoComprar < StandardError

  def initialize(msg )
    super (msg)
  end

end