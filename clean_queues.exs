#!/usr/bin/env elixir
defmodule CleanQueues do
  @moduledoc """
  Documentation for CleanQueues.
  """

  @doc """
    Cleans queues starting with `q.v1.`
  """
  def clean() do
    get_queues()
    |> clean_queues()
  end

  defp get_queues() do
    {queues, _} = System.cmd("/usr/local/opt/rabbitmq/sbin/rabbitmqctl", ["list_queues"])
    queues
    |> String.split("\n")
    |> Enum.filter(fn queue -> String.starts_with?(queue, "q.v1.") end)
    |> Enum.map(fn queue -> String.replace(queue, "\t0", "") end)
  end

  defp clean_queues(queues) do
    queues
    |> Enum.each(fn queue -> clean_queue(queue) end)
  end

  defp clean_queue(queue) do
    IO.puts("Purging: " <> queue)
    System.cmd("/usr/local/opt/rabbitmq/sbin/rabbitmqctl", ["purge_queue", queue])
  end
end

CleanQueues.clean()