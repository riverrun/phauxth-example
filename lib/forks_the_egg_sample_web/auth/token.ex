defmodule ForksTheEggSampleWeb.Auth.Token do
  @moduledoc """
  Custom token implementation using Phauxth.Token behaviour and Phoenix Token.
  """

  @behaviour Phauxth.Token

  alias Phoenix.Token
  alias ForksTheEggSampleWeb.Endpoint

  @token_salt "JaKgaBf2"

  @impl true
  def sign(data, opts \\ []) do
    Token.sign(Endpoint, @token_salt, data, opts)
  end

  @impl true
  def verify(token, opts \\ []) do
    Token.verify(Endpoint, @token_salt, token, opts)
  end
end
