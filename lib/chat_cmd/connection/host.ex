defmodule ChatCmd.Connection.Host do
  def env do
    System.put_env("VHOST", "amqps://fmmdimwu:AZaIdLfqG6ZARwDilhfswU7TYV7h8oJB@albatross.rmq.cloudamqp.com/fmmdimwu")
  end
end
