defmodule GoWeb.GameSvgLive do
  use GoWeb, :live_view

  alias GoEngine.Main

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> new()}
  end

  def handle_event("add_piece", %{"x"=>x, "y"=>y}, socket) do
    x = String.to_integer(x)
    y = String.to_integer(y)

    {:noreply, socket |> add_piece(x, y)}
  end

  defp new(socket) do
    socket
    |> assign(:main,
      Main.new(9)
      |> Main.add_piece(:black, 1, 1)
      |> Main.add_piece(:white, 2, 2)
    )
  end

  defp add_piece(%{assigns: %{main: main}}=socket, x, y) do
    # color = Main.current...
    color = :black
    assign(socket, main: Main.add_piece(main, color, x, y))
  end
end
