#! /usr/bin/env elixir
defmodule CleanQueues do
  @doc """
    Cleans queues starting with `q.v1.`. As an arument plesea provide full path to rabbitmqctl
    for example : `/usr/local/opt/rabbitmq/sbin/rabbitmqctl`
  """
  def clean(rabbitmqctl) do
    rabbitmqctl
    |> get_queues()
    |> clean_queues(rabbitmqctl)
  end

  defp get_queues(rabbitmqctl) do
    {queues, _} = System.cmd(rabbitmqctl, ["list_queues"])

    queues
    |> String.split("\n")
    |> Enum.filter(fn queue -> String.contains?(queue, ".q.") end)
    |> Enum.filter(fn queue -> String.split(queue, "\t") |> Enum.at(1) != "0" end)
    |> Enum.map(fn queue -> String.split(queue, "\t") |> Enum.at(0) end)
  end

  defp clean_queues(queues, rabbitmqctl) do
    queues
    |> Enum.each(fn queue -> clean_queue(queue, rabbitmqctl) end)
  end

  defp clean_queue(queue, rabbitmqctl) do
    IO.puts("Purging: " <> queue)
    System.cmd(rabbitmqctl, ["purge_queue", String.trim(queue)])
  end
end

CleanQueues.clean(System.argv() |> Enum.at(0) || "/usr/local/opt/rabbitmq/sbin/rabbitmqctl")
