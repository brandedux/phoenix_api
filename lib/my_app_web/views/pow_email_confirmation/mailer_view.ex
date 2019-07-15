defmodule MyAppWeb.PowEmailConfirmation.MailerView do
  use MyAppWeb, :mailer_view

  def subject(:email_confirmation, _assigns), do: "Confirm your email address"
end
