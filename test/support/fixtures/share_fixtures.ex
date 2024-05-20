defmodule FileShare.ShareFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FileShare.Share` context.
  """

  @doc """
  Generate a file.
  """
  def file_fixture(attrs \\ %{}) do
    {:ok, file} =
      attrs
      |> Enum.into(%{
        name: "some name",
        password: "some password",
        path: "some path"
      })
      |> FileShare.Share.create_file()

    file
  end
end
