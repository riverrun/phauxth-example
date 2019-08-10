defmodule ForksTheEggSampleWeb.EmailTest do
  use ExUnit.Case
  use Bamboo.Test

  import ForksTheEggSampleWeb.AuthTestHelpers

  alias ForksTheEggSampleWeb.Email

  setup do
    email = "deirdre@example.com"
    {:ok, %{email: email, key: gen_key(email)}}
  end

  test "sends confirmation request email", %{email: email, key: key} do
    link = "http://www.example.com/confirms?key=#{key}"
    sent_email = Email.confirm_request(email, link)
    assert sent_email.subject =~ "Confirm email address"
    assert sent_email.html_body =~ "Click on the link below to confirm this email address"
    assert_delivered_email(Email.confirm_request(email, link))
  end

  test "sends no user found message for password reset attempt" do
    sent_email = Email.reset_request("gladys@example.com", nil)
    assert sent_email.text_body =~ "but no user is associated with the email you provided"
  end

  test "sends reset password request email", %{email: email, key: key} do
    link = "http://www.example.com/password_resets/edit?key=#{key}"
    sent_email = Email.reset_request(email, link)
    assert sent_email.subject =~ "Reset your password"
    assert sent_email.html_body =~ "Click on the link below to reset your password"
    assert_delivered_email(Email.reset_request(email, link))
  end

  test "sends receipt confirmation email", %{email: email} do
    sent_email = Email.confirm_success(email)
    assert sent_email.text_body =~ "account has been confirmed"
    assert_delivered_email(Email.confirm_success(email))
  end

  test "sends password reset email", %{email: email} do
    sent_email = Email.reset_success(email)
    assert sent_email.text_body =~ "password has been reset"
    assert_delivered_email(Email.reset_success(email))
  end
end
