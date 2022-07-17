defmodule ChatCmd.Consumer do
  import System

  use GenServer

  alias ChatCmd.Connection.Host
  def init(_) do
    {:ok, nil}
  end

  def start_link(_) do
    IO.puts("Consumer starter!")
    GenServer.start_link(__MODULE__, nil, name: :consumer)
  end

  def start() do
    Host.env()

    {:ok, connection} = AMQP.Connection.open(get_env("VHOST"))
    {:ok, channel} = AMQP.Channel.open(connection)

    AMQP.Exchange.declare(channel, "talk", :fanout)
    {:ok, %{queue: queue_name}} = AMQP.Queue.declare(channel, "", exclusive: true)

    AMQP.Queue.bind(channel, queue_name, "talk")
    AMQP.Basic.consume(channel, queue_name, nil, no_ack: true)

    IO.puts " [*] Waiting for messages. To exit press CTRL+C, CTRL+C"
    IO.puts "Aguardando mensagens!"
    wait_for_receive_messages(channel)
  end

  def wait_for_receive_messages(channel) do
    receive do
      {:basic_deliver, payload, _meta} ->
        IO.puts " #{payload} "

      wait_for_receive_messages(channel)
    end
  end
end
