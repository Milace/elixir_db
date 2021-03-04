defmodule CursoElixirDbWeb.LivesController do
  use Phoenix.LiveView
  alias CursoElixirDb.HelperScraping

  # def render(assigns) do
  #   ~L"""
  #   <table>
  #   <thead>
  #   <tr>
  #     <th>Title</th>
  #     <th>Descripcion</th>
  #     <th>score</th>
  #     <th>growth</th>


  #     <th></th>
  #   </tr>
  #   </thead>
  #   <tbody>
  #   <%= for card <- @cards do %>
  #   <tr>
  #     <td><%= card.title %></td>
  #     <td><%= card.desc %></td>
  #     <td><%= card.score %></td>
  #     <td><%= card.growth %></td>
  #   </tr>
  #   <% end %>
  #   </tbody>
  #   </table>
  #   """
  # end

  def render(assigns) do
    Phoenix.View.render(CursoElixirDbWeb.ScrapingView, "scraping.html", assigns)
  end

  def mount(_params, _, socket) do
    if connected?(socket), do: :timer.send_interval(10000, self(), :update)
    cards = HelperScraping.list_scrap()
    {:ok, assign(socket, :cards, cards)}
  end

  def handle_info(:update, socket) do
    cards = HelperScraping.list_scrap()
    {:noreply, assign(socket, :cards, cards)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    card = HelperScraping.get_scrap!(id)
    HelperScraping.delete_scrap(card)
    cards = HelperScraping.list_scrap()
    {:noreply, assign(socket, :cards, cards)}
  end

end
