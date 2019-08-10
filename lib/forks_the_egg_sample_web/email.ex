defmodule ForksTheEggSampleWeb.Email do
  @moduledoc """
  A module for sending emails to the user.

  This module provides functions to be used with the Phauxth authentication
  library when confirming users or handling password resets.

  This example uses Bamboo to email users. If you do not want to use Bamboo,
  see the `Using another email library` for instructions on how to adapt this
  example.

  For more information about Bamboo, see the [Bamboo README](https://github.com/thoughtbot/bamboo).

  ## Bamboo adapters

  Bamboo provides adapters for many popular emailing services, and you
  can also create custom adapters by implementing the Bamboo.Adapter behaviour.

  This example is configured to use the MandrillAdapter in production, the
  LocalAdapter in development, and the TestAdapter for tests. To use a
  different adapter, edit the relevant config file.

  ## Email delivery

  All emails in this module use the `deliver_later` function, which sends the
  email straight away, but in the background. The behavior of this function
  can be customized by implementing your own `Bamboo.DeliverLaterStrategy`
  behaviour.

  ## Viewing sent emails

  The `Bamboo.SentEmailViewerPlug` has been added to the `router.ex` file. With this,
  you can view the sent emails in your browser.

  ## Using another email library

  If you do not want to use Bamboo, follow the instructions below:

  1. Edit this file, using the email library of your choice
  2. Remove the lib/forks_the_egg_sample/mailer.ex file
  3. Remove the Bamboo entries in the config/config.exs and config/test.exs files
  4. Remove bamboo from the deps section in the mix.exs file
  """

  import Bamboo.Email

  alias ForksTheEggSampleWeb.Mailer

  @doc """
  An email with a confirmation link in it.
  """
  def confirm_request(address, link) do
    address
    |> base_email()
    |> subject("Confirm email address")
    |> html_body(
      "<h3>Click on the link below to confirm this email address</h3><p><a href=#{link}>Confirm email</a></p>"
    )
    |> Mailer.deliver_later()
  end

  @doc """
  An email with a link to reset the password.
  """
  def reset_request(address, nil) do
    address
    |> base_email()
    |> subject("Reset your password")
    |> text_body(
      "You requested a password reset, but no user is associated with the email you provided."
    )
    |> Mailer.deliver_later()
  end

  def reset_request(address, link) do
    address
    |> base_email()
    |> subject("Reset your password")
    |> html_body(
      "<h3>Click on the link below to reset your password</h3><p><a href=#{link}>Password reset</a></p>"
    )
    |> Mailer.deliver_later()
  end

  @doc """
  An email acknowledging that the account has been successfully confirmed.
  """
  def confirm_success(address) do
    address
    |> base_email()
    |> subject("Confirmed account")
    |> text_body("Your account has been confirmed.")
    |> Mailer.deliver_later()
  end

  @doc """
  An email acknowledging that the password has been successfully reset.
  """
  def reset_success(address) do
    address
    |> base_email()
    |> subject("Password reset")
    |> text_body("Your password has been reset.")
    |> Mailer.deliver_later()
  end

  defp base_email(address) do
    new_email()
    |> to(address)
    |> from("admin@example.com")
  end
end
