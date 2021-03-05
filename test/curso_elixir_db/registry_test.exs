defmodule RegistryTest do
  use ExUnit.Case, async: true

  setup do
    registry = start_supervised!(CursoElixirDb.Registry)
    %{registry: registry}
  end

  # test "spawns create registers into map with GenServer", %{registry: registry} do
  #   assert GenServer.cast(registry, {:create, "llave_1", "valor de la llave 1"}) =:ok
  #   assert {:ok, "valor de la llave 1"} = GenServer.call(registry, {:lookup, "llave_1"})
  # end

  # test "spawns create registers into map with functions GenServer", %{registry: registry} do
  #   assert registry.create(registry, "llave_2", "valor de la llave 2") =:ok
  #   assert {:ok, "valor de la llave 2"} = registry.lookup(registry, "llave_2")
  # end
end
