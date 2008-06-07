class Object
  def try(method, *args, &block)
    send(method, *args, &block) if respond_to?(method)
  end
end