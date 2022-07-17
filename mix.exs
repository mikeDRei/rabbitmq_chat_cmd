defmodule ChatCmd.MixProject do
  use Mix.Project

  def project do
    [
      app: :chat_cmd,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {ChatCmd.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      { :amqp , "~> 1.0" }
    ]
  end
end
