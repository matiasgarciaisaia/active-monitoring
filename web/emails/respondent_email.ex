defmodule ActiveMonitoring.RespondentEmail do
  import Swoosh.Email
  alias Coherence.Config

  def positive_symptoms(%{forwarding_address: forwarding_address}, %{contact_address: contact_address, registration_identifier: registration_identifier}) do
    new()
    |> to(forwarding_address)
    |> from({Config.email_from_name, Config.email_from_email})
    |> subject("Positive symptoms detected for #{contact_address}")
    |> text_body("Hello #{forwarding_address},\ngo to Messenger and look for #{contact_address} (registration identifier: #{registration_identifier}) that reported positive symptoms.\n\nThank you :)")
  end
end
