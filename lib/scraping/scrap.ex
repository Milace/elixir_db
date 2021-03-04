defmodule Scrap do
  import CursoElixirDb.HelperScraping
  alias Poison
  alias CursoElixirDb.HelperScraping.Scraping

  @url "https://explodingtopics.com/"

  def do_get(url \\ @url) do
    case HTTPoison.get(url) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          body |> Floki.parse_document |> find
        {:ok, %HTTPoison.Response{status_code: 404}} ->
          IO.puts "Not found :("
        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.inspect reason
    end
  end

  def find({:ok, document}) do
    container = document |> Floki.find(".topicInfoContainer")

    titles = for{_,_,[titles]} <- container |> Floki.find(".tileKeyword"), do: titles
    descriptions = for{_,_,[descriptions]} <- container |> Floki.find(".tileDescription"), do: descriptions
    score = for{_,_,[score]} <- container |> Floki.find("div.scoreTagItem"), do: score
    growth = for{_,_,[growth]} <- container |> Floki.find("div.scoreTagItem.scoreTagGradient"), do: growth

    [titles, descriptions, score, growth] |> Enum.zip |> insert_or_update(CursoElixirDb.Registry) # Insert normal
    # [titles, descriptions, score, growth] |> Enum.zip |> insert_or_update # Insert normal
  end

  @doc """
   Insert data in data base
  """
  def insert_or_update(list) do
    Enum.map(list, fn {title, desc, score, growth} ->
      case find_scrap_by_title(title) do
         %Scraping{} = scrap -> update_scrap(scrap, %{score: score, growth: growth})
          _ -> create_scrap(%{title: title, desc: desc, score: score, growth: growth})
      end
    end)
  end

  @doc """
   Insert data base using GenServer
  """
  def insert_or_update(list, server) do
    server |> CursoElixirDb.Registry.create(list)
  end
end
