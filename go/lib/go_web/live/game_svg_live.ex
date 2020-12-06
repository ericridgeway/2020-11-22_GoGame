defmodule GoWeb.GameSvgLive do
  use GoWeb, :live_view

  alias GoEngine.Main

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> new()}
  end

  defp new(socket) do
    socket
    |> assign(:main,
      Main.new(9)
      |> Main.add_piece(:black, 1, 1)
      |> Main.add_piece(:white, 2, 2)
    )
  end
end
