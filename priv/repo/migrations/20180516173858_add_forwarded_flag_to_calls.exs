defmodule ActiveMonitoring.Repo.Migrations.AddForwardedFlagToCalls do
  use Ecto.Migration

  def change do
    alter table(:calls) do
      add :forwarded, :boolean, default: false
    end
  end
end
