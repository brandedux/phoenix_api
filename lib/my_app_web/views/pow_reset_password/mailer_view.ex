defmodule MyAppWeb.PowResetPassword.MailerView do
  use MyAppWeb, :mailer_view

  def subject(:reset_password, _assigns), do: "Reset password link"
end
