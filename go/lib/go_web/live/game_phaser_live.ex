defmodule GoWeb.GamePhaserLive do
  use GoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, new(socket)}
  end

  @impl true
  def handle_event("decrement", values, socket) do
    # IO.puts ""; require InspectVars; InspectVars.inspect([values])
    # push_event(socket, "phxEventToJS", %{bark: "woof"})
    {:noreply, socket |> assign(:live_todo, "new") |> push_event("phxEventToJS", %{bark: "woof"})}
  end


  defp new(socket) do
    socket
    |> assign(:live_todo, "asd123")
  end
end
