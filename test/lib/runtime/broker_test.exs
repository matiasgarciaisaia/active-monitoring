defmodule ActiveMonitoring.BrokerTest do
  use ActiveMonitoring.ModelCase
  alias ActiveMonitoring.Runtime.{Broker}
  alias ActiveMonitoring.{Call, RespondentEmail}

  import Swoosh.TestAssertions

  describe "chat forwarding via e-mail" do
    setup [:campaign, :subject, :call, :call_answer_positive]

    test "registers a call as forwarded", %{campaign: campaign, subject: subject} do
      assert Repo.one(Call).forwarded == false

      Broker.handle_info(:notify, nil)

      assert Repo.one(Call).forwarded == true
      assert_email_sent RespondentEmail.positive_symptoms(campaign, subject)
    end
  end

  def campaign(_context) do
    [campaign: insert(:campaign, mode: "chat", forwarding_condition: "any")]
  end

  def subject(%{campaign: campaign}) do
    [subject: insert(:subject, campaign: campaign, contact_address: "Jane Doe")]
  end

  def call(%{campaign: campaign, subject: subject}) do
    [call: insert(:call, campaign: campaign, subject: subject)]
  end

  def call_answer_positive(%{campaign: campaign, call: call}) do
    [call_answer: insert(:call_answer, campaign: campaign, call: call, response: true)]
  end
end
