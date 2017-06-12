defmodule ActiveMonitoring.Channel do
  use ActiveMonitoring.Web, :model

  alias ActiveMonitoring.{Repo,User}

  schema "channels" do
    field :name, :string
    belongs_to :user, User

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name])
  end
end