defmodule MyApp.OauthApplications.OauthApplication do
  use Ecto.Schema
  use ExOauth2Provider.Applications.Application, otp_app: :my_app

  schema "oauth_applications" do
    application_fields()

    timestamps()
  end
end
