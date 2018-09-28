class PolyTreeNode
  attr_reader :value, :parent
  attr_accessor :children

  def initialize(value, parent=nil)
    @value = value
    @parent = parent
    @children = []
  end

  def parent=

  end
end
