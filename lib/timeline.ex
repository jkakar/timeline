defmodule Timeline do
  @doc """
  Transform a list of `{start_time, stop_time}` timelines sorted by start
  time, where event timelines may overlap, into a flattened list of timelines
  without any overlaps.

  ## Example

  iex> Timeline.squash([{1, 3}, {2, 4}])
  [{1, 4}]
  """
  def squash(timelines) do
    List.foldl(timelines, [], &squash/2) |> Enum.reverse
  end

  defp squash({start_time, stop_time}, []) do
    [{start_time, stop_time}]
  end

  # Prepend the current record because it starts after the last record.
  defp squash({start_time, stop_time}, [{_last_start_time, last_stop_time}|_]=acc)
  when last_stop_time < start_time do
    [{start_time, stop_time}|acc]
  end

  # Discard the last record and prepend a new record using the last record's
  # start time and the new record's stop time because the last record
  # partially overlaps the current record.
  defp squash({_start_time, stop_time}, [{last_start_time, last_stop_time}|_]=acc)
  when last_stop_time < stop_time do
     [_|new_acc] = acc
     [{last_start_time, stop_time}|new_acc]
  end

  # Discard the current record because its timeline is contained within the
  # last record.
  defp squash({_start_time, stop_time}, [{_last_start_time, last_stop_time}|_]=acc)
  when last_stop_time >= stop_time do
    acc
  end
end
