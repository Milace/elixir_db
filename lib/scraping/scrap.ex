defmodule Scrap do
  import CursoElixirDb.HelperScraping
  alias Poison

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
    titles = for{_,_,[titles]} <- document |> Floki.find(".gridContainer") |> Floki.find(".topicInfoContainer") |> Floki.find(".tileKeyword"), do: titles
    descriptions = for{_,_,[descriptions]} <- document |> Floki.find(".gridContainer") |> Floki.find(".topicInfoContainer") |> Floki.find(".tileDescription"), do: descriptions
    score = for{_,_,[score]} <- document |> Floki.find(".gridContainer") |> Floki.find(".topicInfoContainer") |> Floki.find(".scoreTagItem"), do: score
    growth = for{_,_,[growth]} <- document |> Floki.find(".gridContainer") |> Floki.find(".topicInfoContainer") |> Floki.find(".scoreTagGradient"), do: growth

    list = create_list(titles, descriptions, score, growth)
    titles |> Enum.zip(list) |> Enum.into(%{}) |> insert_data
  end

  @doc """
   Inserta datos en la base de datos
  """
  def insert_data(data) do
    for {_, x} <- data do
      create_scrap(%{tittle: Enum.at(x, 0),
                      descripcion: Enum.at(x, 1),
                      score: Enum.at(x, 2),
                      growth: Enum.at(x, 3)
                    })
    end
  end

  def create_list(t, d, s, g, acum \\ [])

  def create_list([], _d, _s, _g, acum), do: acum

  def create_list(t, d, s, g, acum) do
    create_list(tl(t), tl(d), tl(s), tl(g),  acum ++ [[hd(t), hd(d), hd(s), hd(g)]])
  end
end
