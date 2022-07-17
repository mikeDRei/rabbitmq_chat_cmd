defmodule ChatCmd.Publisher do
  import System
  use GenServer

  def init(_) do
    {:ok, nil}
  end

  def start_link(_) do
    IO.puts("Publisher starter!")
    GenServer.start_link(__MODULE__, nil, name: :publisher)
  end


  def start do
    {:ok, connection} = AMQP.Connection.open(get_env("VHOST"))
    {:ok, channel} = AMQP.Channel.open(connection)

    name = IO.gets("Informe seu nome: ")

    send_message(name, channel)
  end

  def send_message(name, channel) do
    text = IO.gets("digite sua mensagem para o grupo: ")
    message =
      case System.argv do
      []    -> "#{text}"
      words -> Enum.join(words, " ")
      end

    AMQP.Exchange.declare(channel, "talk", :fanout)
    AMQP.Basic.publish(channel, "talk", "", "#{name} > #{message}")

    IO.puts "[x] Enviado"
    send_message(name, channel)
  end
end
