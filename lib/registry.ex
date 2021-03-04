defmodule CursoElixirDb.Registry do
  use GenServer

  import CursoElixirDb.HelperScraping
  alias CursoElixirDb.HelperScraping.Scraping

  @impl true
  def init(:ok) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:lookup, name}, _from, map_names) do
    #{:reply, resultado de la busqueda, mapa}
    {:reply, Map.fetch(map_names, name), map_names} #sync
  end

  @impl true
  def handle_cast({:create, name, valor}, map_names) do
    if Map.has_key?(map_names, name) do
      {:noreply, name} #async
    else
      {:noreply, Map.put(map_names, name, valor)} #async
    end
  end

  @doc """
  update database
  """
  @impl true
  def handle_cast({:update, %{score: score, growth: growth}, scrap}, _created) do
    update_scrap(scrap, %{score: score, growth: growth})

    {:noreply, %{}}
  end

  @doc """
  insert database
  """
  @impl true
  def handle_cast({:create, %{title: title, desc: desc, score: score, growth: growth}}, _created) do
    create_scrap(%{title: title, desc: desc, score: score, growth: growth})
    {:noreply, %{}}
  end


  @doc """
  Inicio el Genserver de Registry
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  def create(server, name, valor) do
    GenServer.cast(server, {:create, name, valor})
  end

  @doc """
  insert or update database
  """
  def create(server, list) do
    Enum.map(list, fn {title, desc, score, growth} ->
      case find_scrap_by_title(title) do
        %Scraping{} = scrap -> GenServer.cast(server, {:update, %{score: score, growth: growth}, scrap})
        _ -> GenServer.cast(server, {:create, %{title: title, desc: desc, score: score, growth: growth}})
      end
    end)
  end
end
