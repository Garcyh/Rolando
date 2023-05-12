module FuerzaOscura

  @valor = 5

  def self.valor
    @valor
  end

  def self.eclipse!
    @valor = @valor * 2
  end

  def self.cambiarValor(unValor)
    @valor = unValor
  end

end
