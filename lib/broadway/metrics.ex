defmodule Broadway.Metrics do
  def dispatch_running_event([], []) do
    :ok
  end

  def dispatch_running_event(events, stage_pid) do
    value = %{
      time: System.monotonic_time(),
      n_messages: length(events)
    }
    :telemetry.execute([:broadway, :stage_run], value, %{stage_pid: stage_pid})
  end

  def dispatch_ack_event([], []) do
    :ok
  end

  def dispatch_ack_event(successful_messages_to_ack, failed_messages, source) do
    value = %{
      success: length(successful_messages_to_ack),
      failed: length(failed_messages),
      time: System.system_time()
    }
    :telemetry.execute([:broadway, :ack], value, %{event_source: source})
  end
end
